# Outputs for Main S3 Bucket
# This file defines all outputs for the main S3 bucket configuration including:
# - Basic bucket information
# - Security configurations
# - Versioning status
# - Logging configuration

# Basic bucket information
output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "The domain name of the S3 bucket"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

# Versioning configuration
output "versioning_status" {
  description = "The versioning status of the S3 bucket"
  value       = aws_s3_bucket_versioning.versioning.versioning_configuration[0].status
}

# Encryption configuration
output "encryption_configuration" {
  description = "The encryption configuration of the S3 bucket"
  value       = aws_s3_bucket_server_side_encryption_configuration.encryption.rule
}

# Bucket policy
output "bucket_policy" {
  description = "The bucket policy attached to the S3 bucket"
  value       = aws_s3_bucket_policy.bucket_policy.policy
}

# Logging configuration
output "logging_configuration" {
  description = "The logging configuration of the S3 bucket"
  value       = var.enable_logging ? aws_s3_bucket_logging.logging[0] : null
}

# Tags
output "bucket_tags" {
  description = "The tags attached to the S3 bucket"
  value       = aws_s3_bucket.main.tags
}



# Outputs for the logging bucket

output "logging_bucket_id" {
  description = "The ID of the logging bucket"
  value       = aws_s3_bucket.logging.id
}

output "logging_bucket_arn" {
  description = "The ARN of the logging bucket"
  value       = aws_s3_bucket.logging.arn
}

output "logging_bucket_domain_name" {
  description = "The domain name of the logging bucket"
  value       = aws_s3_bucket.logging.bucket_domain_name
}

output "logging_bucket_regional_domain_name" {
  description = "The regional domain name of the logging bucket"
  value       = aws_s3_bucket.logging.bucket_regional_domain_name
}

output "logging_bucket_name" {
  description = "The name of the logging bucket"
  value       = aws_s3_bucket.logging.bucket
}

output "logging_bucket_policy" {
  description = "The policy of the logging bucket"
  value       = aws_s3_bucket_policy.logging_policy.policy
}

output "logging_bucket_encryption_configuration" {
  description = "The encryption configuration of the logging bucket"
  value       = aws_s3_bucket_server_side_encryption_configuration.logging_encryption.rule
}

output "logging_bucket_lifecycle_rules" {
  description = "The lifecycle rules of the logging bucket"
  value       = aws_s3_bucket_lifecycle_configuration.logging_lifecycle.rule
}
