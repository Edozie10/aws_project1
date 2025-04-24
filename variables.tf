# Root variables.tf

# Root variables.tf for VPC
# This will be used in tags and identifiers
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my_vpc"
}


# Environment identifier (e.g., dev, staging, prod)
# Used for resource tagging and naming
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}



# Primary CIDR block for the VPC
# Defines the IP address range for the entire VPC
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}



# List of Availability Zones to use
# Typically use at least 2 AZs for high availability
variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


# CIDR blocks for public subnets
# These subnets will have direct internet access
variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}






# CIDR blocks for private subnets
# These subnets will access internet via NAT Gateway
variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}


# Toggle for NAT Gateway creation
# Set to false to disable NAT Gateway if not needed
variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}



# Optional VPC ID for VPC peering
# Leave empty if no VPC peering is required
variable "peer_vpc_id" {
  description = "VPC ID to peer with (optional)"
  type        = string
  default     = ""
}


# Root variables.tf for security groups

# Name of the security group
# This will be used as the identifier for the security group
variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "allow_tls"
}

# Description for the security group
# Provides context about the security group's purpose
variable "security_group_description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow TLS inbound traffic and all outbound traffic"
}

# VPC ID where the security group will be created
# This should typically come from your VPC module output
variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
  # No default as this should be provided by the VPC module
}

# IPv4 CIDR block for ingress rules
# Defines allowed incoming IPv4 traffic
variable "vpc_cidr_block" {
  description = "CIDR block for IPv4 ingress rule"
  type        = string
  # No default as this should be provided based on your network design
  default = "10.0.0.0/16"
}

# IPv6 CIDR block for ingress rules
# Defines allowed incoming IPv6 traffic
variable "vpc_ipv6_cidr_block" {
  description = "CIDR block for IPv6 ingress rule"
  type        = string
  # No default as this should be provided based on your network design
}

# Port number for TLS traffic
# Standard HTTPS port is 443
variable "tls_port" {
  description = "Port number for TLS traffic"
  type        = number
  default     = 443
}

# IPv4 CIDR for egress rules
# Default allows all outbound IPv4 traffic
variable "ipv4_egress_cidr" {
  description = "IPv4 CIDR block for egress traffic"
  type        = string
  default     = "0.0.0.0/0"
}

# IPv6 CIDR for egress rules
# Default allows all outbound IPv6 traffic
variable "ipv6_egress_cidr" {
  description = "IPv6 CIDR block for egress traffic"
  type        = string
  default     = "::/0"
}

# Resource tags
# Map of tags to apply to the security group
variable "security_group_tags" {
  description = "Tags to be applied to the security group"
  type        = map(string)
  default = {
    Name = "allow_tls"
  }
}

#s3 bucket Variables 

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-secure-bucket-name"
}

variable "bucket_environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable logging on the bucket"
  type        = bool
  default     = false
}

variable "api_gateway_config" {
  description = "Configuration for API Gateway"
  type = object({
    api_name        = string
    api_description = string
    environment     = string
    resource_path   = string
    http_method     = string
    stage_name      = string
  })
  default = {
    api_name        = "my-terraform-api"
    api_description = "Terraform managed API Gateway"
    environment     = "production"
    resource_path   = "v1"
    http_method     = "GET"
    stage_name      = "prod"
  }
}

variable "endpoint_configuration" {
  description = "API Gateway endpoint configuration"
  type = object({
    types = list(string)
  })
  default = {
    types = ["REGIONAL"]
  }
}

variable "authorization_config" {
  description = "API Gateway authorization configuration"
  type = object({
    type = string
  })
  default = {
    type = "NONE"
  }
}

variable "monitoring_config" {
  description = "Monitoring and logging configuration"
  type = object({
    enable_cloudwatch_logs = bool
    enable_xray_tracing    = bool
  })
  default = {
    enable_cloudwatch_logs = true
    enable_xray_tracing    = true
  }
}

variable "domain_config" {
  description = "Custom domain configuration"
  type = object({
    domain_name     = string
    certificate_arn = string
  })
  default = {
    domain_name     = null
    certificate_arn = null
  }
}

variable "waf_config" {
  description = "WAF configuration"
  type = object({
    web_acl_id = string
  })
  default = {
    web_acl_id = null
  }
}

variable "request_config" {
  description = "Request configuration"
  type = object({
    parameters = map(bool)
    templates  = map(string)
  })
  default = {
    parameters = {}
    templates  = {}
  }
}

variable "request_templates" {
  description = "A map of request templates for the MOCK integration"
  type        = map(string)
  default = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "terraform-demo"
    Owner       = "devops-team"
    ManagedBy   = "terraform"
  }
}
