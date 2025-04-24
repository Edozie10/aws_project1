# outputs.tf

# API Gateway Outputs
output "rest_api_id" {
  description = "ID of the REST API"
  value       = aws_api_gateway_rest_api.main.id
}

output "rest_api_arn" {
  description = "ARN of the REST API"
  value       = aws_api_gateway_rest_api.main.arn
}

output "rest_api_execution_arn" {
  description = "Execution ARN of the REST API"
  value       = aws_api_gateway_rest_api.main.execution_arn
}

output "resource_id" {
  description = "ID of the API Gateway Resource"
  value       = aws_api_gateway_resource.main.id
}

output "resource_path" {
  description = "Path of the API Gateway Resource"
  value       = aws_api_gateway_resource.main.path
}



output "method_id" {
  description = "ID of the API Gateway Method"
  value       = aws_api_gateway_method.main.id
}

output "deployment_id" {
  description = "ID of the API Gateway Deployment"
  value       = aws_api_gateway_deployment.main.id
}

output "stage_name" {
  description = "Name of the API Gateway Stage"
  value       = aws_api_gateway_stage.main.stage_name
}

output "stage_arn" {
  description = "ARN of the API Gateway Stage"
  value       = aws_api_gateway_stage.main.arn
}

output "invoke_url" {
  description = "URL to invoke the API"
  value       = aws_api_gateway_stage.main.invoke_url
}

output "execution_arn" {
  description = "Execution ARN to be used in lambda permission"
  value       = "${aws_api_gateway_rest_api.main.execution_arn}/*/${var.http_method}${aws_api_gateway_resource.main.path}"
}

output "domain_name" {
  description = "Custom domain name (if configured)"
  value       = var.domain_name != null ? aws_api_gateway_domain_name.main[0].domain_name : null
}

output "cloudwatch_role_arn" {
  description = "ARN of the CloudWatch role (if logging enabled)"
  value       = var.enable_cloudwatch_logs ? aws_iam_role.cloudwatch[0].arn : null
}
