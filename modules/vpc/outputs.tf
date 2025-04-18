
#this are the output of everything based upon the main.tf


# Outputs the ID of the created VPC
# This is commonly used when you need to reference the VPC in other resources
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Outputs a list of all public subnet IDs
# The [*] syntax gets all subnet IDs when multiple subnets are created
# Used when launching resources that need to be in public subnets
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

# Outputs a list of all private subnet IDs
# Similar to public subnets, but for private subnet resources
# Commonly used for RDS, ECS tasks, etc.
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

# Outputs the NAT Gateway ID if it's enabled
# Uses conditional expression: if NAT Gateway is enabled, output its ID, otherwise null
# Important for debugging and resource tracking
output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_nat_gateway.main[0].id : null
}

# Outputs the ID of the main security group
# Used when you need to add rules or associate with EC2 instances
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.main.id
}

# Outputs the ID of the VPC Flow Log
# Useful for monitoring and debugging network traffic
output "vpc_flow_log_id" {
  description = "ID of VPC Flow Log"
  value       = aws_flow_log.main.id
}

# Outputs the CIDR block of the VPC
# Useful for security group rules and network planning
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Outputs the ID of the public route table
# Used for adding custom routes or associating additional subnets
output "public_route_table_id" {
  description = "ID of public route table"
  value       = aws_route_table.public.id
}

# Outputs the IDs of all private route tables
# Similar to public route table, but for private subnets
output "private_route_table_ids" {
  description = "IDs of private route tables"
  value       = aws_route_table.private[*].id
}

# Outputs the Internet Gateway ID
# Required when setting up routing to the internet
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}
