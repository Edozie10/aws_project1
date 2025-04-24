#Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

# S3 Bucket Main Configuration
# Create the main S3 bucket
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

}

#Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
# S3 Bucket Versioning Configuration
# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.main.id
  
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

#Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
# S3 Bucket Encryption Configuration
# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
# S3 Bucket Policy Configuration
# Attach policy to the S3 bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.main.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceSSLOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

#Source: registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging
# S3 Bucket Logging Configuration
# Enable logging for the S3 bucket 
resource "aws_s3_bucket_logging" "logging" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.main.id
 
  target_bucket = aws_s3_bucket.logging.id  # Point to the logging bucket
  target_prefix = "${var.bucket_name}/"
}


