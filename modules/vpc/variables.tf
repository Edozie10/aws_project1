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

