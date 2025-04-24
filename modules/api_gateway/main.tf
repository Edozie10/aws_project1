# this is the main.tf file 
# API Gateway REST API
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api

resource "aws_api_gateway_rest_api" "main" {
  name        = var.api_name
  description = var.api_description

  endpoint_configuration {
    types = var.endpoint_types # e.g., ["REGIONAL", "EDGE", "PRIVATE"]
  }

  tags = merge(
    {
      Name        = var.api_name
      Environment = var.environment
    },
    var.tags
  )
}

# API Gateway Resource
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource

resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = var.resource_path
}

# API Gateway Method
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response

resource "aws_api_gateway_method" "main" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = var.http_method
  authorization = var.authorization_type

  request_parameters = var.request_parameters
}

# MOCK
resource "aws_api_gateway_integration" "main" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.main.id
  http_method             = aws_api_gateway_method.main.http_method
  integration_http_method = "POST"
  type                    = "MOCK"

  request_templates = var.request_templates
}










# API Gateway Method Response
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_response
resource "aws_api_gateway_method_response" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = aws_api_gateway_method.main.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

# API Gateway Integration Response
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration

resource "aws_api_gateway_integration_response" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = aws_api_gateway_method.main.http_method
  status_code = aws_api_gateway_method_response.main.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# API Gateway Deployment
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  depends_on = [
    aws_api_gateway_integration.main,
    aws_api_gateway_integration_response.main
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway Stage
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id  = aws_api_gateway_rest_api.main.id
  stage_name   = var.stage_name

  xray_tracing_enabled = var.enable_xray_tracing

  tags = merge(
    {
      Name        = "${var.api_name}-${var.stage_name}"
      Environment = var.environment
    },
    var.tags
  )
}


# Optional: API Gateway WAF Association
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafregional_web_acl_association

resource "aws_wafregional_web_acl_association" "main" {
  count        = var.waf_web_acl_id != null ? 1 : 0
  resource_arn = aws_api_gateway_stage.main.arn
  web_acl_id   = var.waf_web_acl_id
}

# Optional: API Gateway Domain Name
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name

resource "aws_api_gateway_domain_name" "main" {
  count           = var.domain_name != null ? 1 : 0
  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn

  endpoint_configuration {
    types = var.endpoint_types
  }
}

# Optional: CloudWatch Log Role
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

resource "aws_iam_role" "cloudwatch" {
  count = var.enable_cloudwatch_logs ? 1 : 0
  name  = "${var.api_name}-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

# Optional: CloudWatch Log Policy
# Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
resource "aws_iam_role_policy" "cloudwatch" {
  count = var.enable_cloudwatch_logs ? 1 : 0
  name  = "${var.api_name}-cloudwatch-policy"
  role  = aws_iam_role.cloudwatch[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}