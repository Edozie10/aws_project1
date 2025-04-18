


# cmment on whatthose variables are for 
# do it for every variable 

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my_vpc"
}

variable "environment" {
  description = "Environment name"
  type        = string
   default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a" , "us-east-1b" , "us-east-1c"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] 
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]  # Different range from public subnets

}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}

variable "peer_vpc_id" {
  description = "VPC ID to peer with (optional)"
  type        = string
  default     = ""
}


# # Defines the name of the VPC that will be created
# # This name will be used as a tag for the VPC and its associated resources
# # If not specified, it defaults to "my_vpc"
# variable "vpc_name" {
#   description = "Name of the VPC"
#   type        = string
#   default     = "my_vpc"
# }

# # Specifies the environment this VPC belongs to (e.g., dev, staging, prod)
# # Used for resource tagging and identification
# # Defaults to "dev" if not specified
# variable "environment" {
#   description = "Environment name"
#   type        = string
#    default     = "dev"
# }

# # Defines the IP address range for the entire VPC
# # Uses CIDR notation (e.g., 10.0.0.0/16 provides 65,536 IP addresses)
# # Default value follows AWS VPC best practices for private networks
# variable "vpc_cidr" {
#   description = "CIDR block for VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# # Lists the AWS Availability Zones where resources will be created
# # Distributes resources across multiple AZs for high availability
# # Default uses three AZs in the us-east-1 (N. Virginia) region
# variable "azs" {
#   description = "Availability zones"
#   type        = list(string)
#   default     = ["us-east-1a" , "us-east-1b" , "us-east-1c"]
# }

# # Defines IP ranges for public subnets (one per AZ)
# # These subnets will have direct internet access via Internet Gateway
# # Default creates three /24 subnets (254 usable IPs each) in 10.0.x.0 range
# variable "public_subnets" {
#   description = "CIDR blocks for public subnets"
#   type        = list(string)
#   default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] 
# }

# # Defines IP ranges for private subnets (one per AZ)
# # These subnets have no direct internet access (must use NAT Gateway)
# # Default creates three /24 subnets in 10.0.1x.0 range, separate from public subnets
# variable "private_subnets" {
#   description = "CIDR blocks for private subnets"
#   type        = list(string)
#   default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]  # Different range from public subnets

# }

# # Controls whether to create a NAT Gateway for private subnets
# # When true, allows resources in private subnets to access internet
# # Defaults to true but can be disabled to reduce costs in dev/test environments
# variable "enable_nat_gateway" {
#   description = "Enable NAT Gateway"
#   type        = bool
#   default     = true
# }

# # Optional VPC ID for setting up VPC peering
# # Leave empty if no VPC peering is required
# # Format example: vpc-1234567890abcdef0
# variable "peer_vpc_id" {
#   description = "VPC ID to peer with (optional)"
#   type        = string
#   default     = ""
# }
