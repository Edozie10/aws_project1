# variables.tf

# Core API Gateway Configuration

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "my-api-name"  # Add default value here
}
# Provides a description for the API Gateway with a default value
variable "api_description" {
  description = "Description of the API Gateway"
  type        = string
  default     = "API Gateway managed by Terraform"
}

# Specifies the environment (e.g., dev, prod, staging) for resource tagging
variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

# Allows additional custom tags to be added to resources
variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}

# Endpoint Configuration
# Defines the type of API Gateway endpoint to create
# Can be EDGE (CloudFront), REGIONAL, or PRIVATE
variable "endpoint_types" {
  description = "List of endpoint types. Valid values: EDGE, REGIONAL, PRIVATE"
  type        = list(string)
  default     = ["REGIONAL"]
}



# Defines the path part for the API resource (e.g., /users, /orders)
variable "resource_path" {
  description = "Path part for the API resource"
  type        = string
}

# Specifies the HTTP method for the API endpoint (GET, POST, etc.)
variable "http_method" {
  description = "HTTP method for the API Gateway method"
  type        = string
  default     = "POST"
}

# Configures any required request parameters for the method
variable "authorization_type" {
  description = "Authorization type for the method"
  type        = string
  default     = "NONE"
}

# This variable accepts a map of boolean values that specify required request parameters
variable "request_parameters" {
  description = "Request parameters configuration"
  type        = map(bool)
  default     = {}
}

# Integration Configuration
variable "integration_http_method" {
  description = "Integration HTTP method"
  type        = string
  default     = "POST"
}

variable "integration_type" {
  description = "Integration type (AWS, AWS_PROXY, HTTP, HTTP_PROXY, MOCK)"
  type        = string
  default     = "AWS_PROXY"
}



# Define request templates if needed for mock responses
variable "request_templates" {
  description = "A map of request templates for the integration"
  type        = map(string)
  default     = {
    "application/json" = <<EOF
    {
      "statusCode": 200
    }
    EOF
  }
}


# Stage Configuration
variable "stage_name" {
  description = "Name of the stage"
  type        = string
  default     = "dev"
}


variable "enable_xray_tracing" {
  description = "Enable X-Ray tracing for API Gateway"
  type        = bool
  default     = false
}


# Optional WAF Web ACL ID for API protection
variable "waf_web_acl_id" {
  description = "ID of WAF Web ACL to associate with the API Gateway"
  type        = string
  default     = null
}

# Custom Domain Configuration
variable "domain_name" {
  description = "Custom domain name for the API Gateway"
  type        = string
  default     = null
}


# The ARN (Amazon Resource Name) of an SSL/TLS certificate managed by AWS Certificate Manager (ACM)
# This certificate is required when setting up a custom domain name for your API Gateway
variable "certificate_arn" {
  description = "ARN of ACM certificate for the custom domain"
  type        = string
  default     = null
}

# CloudWatch Logs Configuration
variable "enable_cloudwatch_logs" {
  description = "Enable CloudWatch logging for API Gateway"
  type        = bool
  default     = false
}





