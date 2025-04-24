# Root outputs.tf
# These outputs reference the VPC module outputs for use in other modules or external consumption

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}



output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "default_security_group_id" {
  description = "ID of the security group"
  value       = module.vpc.security_group_id
}


output "vpc_flow_log_id" {
  description = "ID of VPC Flow Log"
  value       = module.vpc.vpc_flow_log_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_route_table_id" {
  description = "ID of public route table"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_ids" {
  description = "IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}


# Root outputs.tf for security group
# These outputs reference the security group module outputs

output "application_security_group_id" {
  description = "The ID of the security group"
  value       = module.security_groups.security_group_id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.security_groups.security_group_name
}

output "security_group_vpc_id" {
  description = "The VPC ID of the security group"
  value       = module.security_groups.security_group_vpc_id
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.security_groups.security_group_arn
}

output "ipv4_ingress_rule_id" {
  description = "The ID of the IPv4 ingress rule"
  value       = module.security_groups.ipv4_ingress_rule_id
}

output "ipv6_ingress_rule_id" {
  description = "The ID of the IPv6 ingress rule"
  value       = module.security_groups.ipv6_ingress_rule_id
}

output "ipv4_egress_rule_id" {
  description = "The ID of the IPv4 egress rule"
  value       = module.security_groups.ipv4_egress_rule_id
}

output "ipv6_egress_rule_id" {
  description = "The ID of the IPv6 egress rule"
  value       = module.security_groups.ipv6_egress_rule_id
}

output "security_group_description" {
  description = "The description of the security group"
  value       = module.security_groups.security_group_description
}

output "security_group_tags" {
  description = "The tags of the security group"
  value       = module.security_groups.security_group_tags
}



output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}



# Outputs
output "api_gateway_id" {
  description = "ID of the API Gateway REST API"
  value       = module.api_gateway.rest_api_id
}

output "api_gateway_endpoint" {
  description = "Endpoint URL of the API Gateway"
  value       = module.api_gateway.api_endpoint
}

output "api_gateway_stage_arn" {
  description = "ARN of the API Gateway stage"
  value       = module.api_gateway.stage_arn
}
output "rest_api_id" {
  description = "ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.main.id
}

output "api_endpoint" {
  description = "Endpoint URL of the API Gateway"
  value       = aws_api_gateway_stage.main.invoke_url
}

output "stage_arn" {
  description = "ARN of the API Gateway stage"
  value       = aws_api_gateway_stage.main.arn
}

