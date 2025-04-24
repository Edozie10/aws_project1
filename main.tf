# coment on the location of the file 

# Calls the vpc module in root main.tf
module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  environment     = "dev"

}


module "s3_bucket" {
  source = "./modules/s3_bucket" # Path to your S3 bucket module

  bucket_name       = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  bucket_name_log   = "my-unique-terraform-bucket-2024-logs" # Added this line
  environment       = "production"
  enable_versioning = true
  enable_logging    = true

  tags = {
    Name        = "my-unique-terraform-bucket-2024"
    Environment = "production"
    Project     = "terraform-demo"
    Owner       = "devops-team"
  }
}





# Calls the Security Group module in root main.tf
module "security_group" {
  source                     = "./modules/security_groups" # Adjust path based on your module location
  security_group_name        = "allow-tls-sg"
  security_group_description = "Security group to allow TLS traffic"
  vpc_id                     = module.vpc.vpc_id # Reference VPC module output
  vpc_cidr_block             = "10.0.0.0/16"     # IPv4 CIDR for inbound TLS
  vpc_ipv6_cidr_block        = "::/0"            # IPv6 CIDR for inbound TLS
  tls_port                   = 443               # Standard HTTPS port
  ipv4_egress_cidr           = "0.0.0.0/0"       # Allow all IPv4 outbound
  ipv6_egress_cidr           = "::/0"            # Allow all IPv6 outbound
}




module "api_gateway" {
  source = "./modules/api_gateway" # Path to your API Gateway module

  api_name        = "my-terraform-api"
  api_description = "My Terraform managed API Gateway"
  environment     = "production"

  # Resource and Method configuration
  resource_path      = "v1"
  http_method        = "GET"
  authorization_type = "NONE"

  # Endpoint Configuration
  endpoint_types = ["REGIONAL"]

  # Stage Configuration
  stage_name          = "prod"
  enable_xray_tracing = true

  # Optional Features
  enable_cloudwatch_logs = true

  # Domain Configuration (Optional - remove if not needed)
  domain_name     = null
  certificate_arn = null

  # WAF Configuration (Optional - remove if not needed)
  waf_web_acl_id = null

  # Request/Response Configuration
  request_parameters = {}
  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }

  # Tags
  tags = {
    Project     = "terraform-demo"
    Owner       = "devops-team"
    Environment = "production"
  }
}
