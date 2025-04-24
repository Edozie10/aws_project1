
# Output for the security group ID
output "application_security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.allow_tls.id
}

# Output for the security group name
output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.allow_tls.name
}

# Output for the security group VPC ID
output "security_group_vpc_id" {
  description = "The VPC ID of the security group"
  value       = aws_security_group.allow_tls.vpc_id
}

# Output for the security group ARN
output "security_group_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.allow_tls.arn
}

# Output for IPv4 ingress rule ID
output "ipv4_ingress_rule_id" {
  description = "The ID of the IPv4 ingress rule"
  value       = aws_vpc_security_group_ingress_rule.allow_tls_ipv4.id
}

# Output for IPv6 ingress rule ID
output "ipv6_ingress_rule_id" {
  description = "The ID of the IPv6 ingress rule"
  value       = aws_vpc_security_group_ingress_rule.allow_tls_ipv6.id
}

# Output for IPv4 egress rule ID
output "ipv4_egress_rule_id" {
  description = "The ID of the IPv4 egress rule"
  value       = aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4.id
}

# Output for IPv6 egress rule ID
output "ipv6_egress_rule_id" {
  description = "The ID of the IPv6 egress rule"
  value       = aws_vpc_security_group_egress_rule.allow_all_traffic_ipv6.id
}

# Output for security group description
output "security_group_description" {
  description = "The description of the security group"
  value       = aws_security_group.allow_tls.description
}

# Output for security group tags
output "security_group_tags" {
  description = "The tags of the security group"
  value       = aws_security_group.allow_tls.tags
}

