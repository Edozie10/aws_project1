# Create a security group to allow TLS traffic
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "allow_tls" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = var.security_group_tags
}

# Allow inbound TLS traffic from IPv4 CIDR block
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4        = var.vpc_cidr_block
  from_port        = var.tls_port
  ip_protocol      = "tcp"
  to_port          = var.tls_port
}

# Allow inbound TLS traffic from IPv6 CIDR block
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6        = var.vpc_ipv6_cidr_block
  from_port        = var.tls_port
  ip_protocol      = "tcp"
  to_port          = var.tls_port
}

# Allow all outbound IPv4 traffic (-1 represents all protocols)
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4        = var.ipv4_egress_cidr
  ip_protocol      = "-1"
}


# Allow all outbound IPv6 traffic (-1 represents all protocols)
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6        = var.ipv6_egress_cidr
  ip_protocol      = "-1"
}
