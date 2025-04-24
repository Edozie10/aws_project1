# Variable for security group name
variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "allow_tls"
}

# Variable for security group description
variable "security_group_description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow TLS inbound traffic and all outbound traffic"
}

# Variable for VPC ID
variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
  
}

# Variable for IPv4 CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for IPv4 ingress rule"
  type        = string
}

# Variable for IPv6 CIDR block
variable "vpc_ipv6_cidr_block" {
  description = "CIDR block for IPv6 ingress rule"
  type        = string
}

# Variable for TLS port
variable "tls_port" {
  description = "Port number for TLS traffic"
  type        = number
  default     = 443
}

# Variable for IPv4 egress CIDR
variable "ipv4_egress_cidr" {
  description = "IPv4 CIDR block for egress traffic"
  type        = string
  default     = "0.0.0.0/0"
}

# Variable for IPv6 egress CIDR
variable "ipv6_egress_cidr" {
  description = "IPv6 CIDR block for egress traffic"
  type        = string
  default     = "::/0"
}

# Variable for tags
variable "security_group_tags" {
  description = "Tags to be applied to the security group"
  type        = map(string)
  default     = {
    Name = "allow_tls"
  }
}
