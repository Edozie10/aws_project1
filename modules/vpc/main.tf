#--------------------------------------------------------------
# VPC Module Main Configuration
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
#--------------------------------------------------------------

# Create the main VPC
# This resource creates a VPC with DNS support and DNS hostnames enabled
# The CIDR block is configurable through variables
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true  # Enables DNS hostnames in the VPC
  enable_dns_support   = true  # Enables DNS support in the VPC

  tags = {
    Name        = var.vpc_name
    Environment = var.environment
  }
}

#--------------------------------------------------------------
# Subnet Configuration
#--------------------------------------------------------------

# Create public subnets
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# These subnets will have direct internet access through the Internet Gateway
# The count parameter creates multiple subnets based on the public_subnets variable
resource "aws_subnet" "public" {
  count             = length(var.public_subnets) ## Controls HOW MANY subnets to create
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index] #  # Defines the IP range for EACH subnet
  availability_zone = var.azs[count.index]  # Spreads subnets across different AZs

  map_public_ip_on_launch = true  # Automatically assign public IPs to instances in these subnets

  tags = {
    Name        = "${var.vpc_name}-public-${var.azs[count.index]}"
    Environment = var.environment
  }
}

# Create private subnets
# These subnets will not have direct internet access
# Internet access will be through NAT Gateway if enabled
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name        = "${var.vpc_name}-private-${var.azs[count.index]}"
    Environment = var.environment
  }
}



# Create Internet Gateway
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

# This allows communication between VPC and the internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
  }
}

#--------------------------------------------------------------
# NAT Gateway Configuration
#--------------------------------------------------------------

# Create Elastic IP for NAT Gateway
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# This provides a static public IP address for the NAT Gateway
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? 1 : 0  # Only create if NAT Gateway is enabled
  domain = "vpc"

  tags = {
    Name        = "${var.vpc_name}-nat-eip"
    Environment = var.environment
  }
}

# Create NAT Gateway
#Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
# This allows private subnet resources to access the internet
resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id  # Associates the Elastic IP
  subnet_id     = aws_subnet.public[0].id  # Places NAT Gateway in the first public subnet

  tags = {
    Name        = "${var.vpc_name}-nat"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]  # Ensures Internet Gateway is created first
}

#--------------------------------------------------------------
# Route Table Configuration
#--------------------------------------------------------------

# Create public route table
# This table will route traffic to the internet through the Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"  # Route all internet-bound traffic
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-rt"
    Environment = var.environment
  }
}

# Create private route table
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# This table will route traffic to the internet through the NAT Gateway (if enabled)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    # Conditional: If NAT Gateway is enabled, use NAT Gateway ID from main[0], otherwise set to null (no route)
    nat_gateway_id = var.enable_nat_gateway ? aws_nat_gateway.main[0].id : null
  }

  tags = {
    Name        = "${var.vpc_name}-private-rt"
    Environment = var.environment
  }
}


#--------------------------------------------------------------
# Security Group Configuration
#--------------------------------------------------------------

# Create Security Group
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# This controls inbound and outbound traffic at the instance level
resource "aws_security_group" "main" {
  name_prefix = "${var.vpc_name}-sg"
  vpc_id      = aws_vpc.main.id

# Allow HTTPS inbound
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-sg"
    Environment = var.environment
  }
}

#--------------------------------------------------------------
# Network ACL Configuration
#--------------------------------------------------------------

# Create Network ACL
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl
# This provides an additional layer of security at the subnet level
resource "aws_network_acl" "main" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
# Inbound rules - Controls traffic coming INTO your VPC
ingress {
    protocol   = "tcp"          # Using TCP protocol for web traffic
    rule_no    = 100           # Lower number rules are evaluated first
    action     = "allow"        # Permits the traffic
    cidr_block = var.vpc_cidr   # Only allows traffic from within your VPC
    from_port  = 443           # HTTPS port
    to_port    = 443           # Same as from_port for single port access
}

ingress {
    protocol   = "tcp"          # Using TCP protocol for web traffic
    rule_no    = 200           # Secondary rule, evaluated after rule 100
    action     = "allow"        # Permits the traffic
    cidr_block = var.vpc_cidr   # Only allows traffic from within your VPC
    from_port  = 80            # HTTP port
    to_port    = 80            # Same as from_port for single port access
}

# Outbound rules - Controls traffic going OUT from your VPC
egress {
    protocol   = "tcp"          # Using TCP protocol for web traffic
    rule_no    = 100           # Lower number rules are evaluated first
    action     = "allow"        # Permits the traffic
    cidr_block = "0.0.0.0/0"    # Allows traffic to any destination on internet
    from_port  = 443           # HTTPS port
    to_port    = 443           # Same as from_port for single port access
}

egress {
    protocol   = "tcp"          # Using TCP protocol for web traffic
    rule_no    = 200           # Secondary rule, evaluated after rule 100
    action     = "allow"        # Permits the traffic
    cidr_block = "0.0.0.0/0"    # Allows traffic to any destination on internet
    from_port  = 80            # HTTP port
    to_port    = 80            # Same as from_port for single port access
}


  tags = {
    Name        = "${var.vpc_name}-nacl"
    Environment = var.environment
  }
}

#--------------------------------------------------------------
# VPC Flow Logs Configuration
#--------------------------------------------------------------

# Create VPC Flow Log
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# This captures information about IP traffic going to and from network interfaces in the VPC
resource "aws_flow_log" "main" {
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.flow_log.arn
  traffic_type    = "ALL"  # Captures all traffic (ACCEPT and REJECT)
  vpc_id          = aws_vpc.main.id

  tags = {
    Name        = "${var.vpc_name}-flow-log"
    Environment = var.environment
  }
}

# Create CloudWatch Log Group for Flow Logs
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log
# This is where the VPC Flow Logs will be stored
resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "/aws/vpc/${var.vpc_name}-flow-logs"
  retention_in_days = 30  # Logs will be kept for 30 days

  tags = {
    Name        = "${var.vpc_name}-flow-log-group"
    Environment = var.environment
  }
}

# Create IAM Role for Flow Logs
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# This role allows VPC Flow Logs to write to CloudWatch Logs
resource "aws_iam_role" "flow_log" {
  name = "${var.vpc_name}-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

# Create IAM Role Policy for Flow Logs
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
# This policy defines the permissions for the Flow Logs role
resource "aws_iam_role_policy" "flow_log" {
  name = "${var.vpc_name}-flow-log-policy"
  role = aws_iam_role.flow_log.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}


