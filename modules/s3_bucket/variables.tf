
# Variable for S3 bucket name
variable "bucket_name" {
  description = "Name of the S3 bucket - must be globally unique"
  type        = string
   default     = "my-unique-bucket-name-2024"
}

# Variable for environment tag
variable "bucket_environment" {
  description = "Environment name for tagging (e.g., prod, dev, staging)"
  type        = string
}

# Variable to control versioning
variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

# Variable to control logging
variable "enable_logging" {
  description = "Enable logging for the S3 bucket"
  type        = bool
  default     = false
}

# Variable for encryption algorithm
variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use"
  type        = string
  default     = "AES256"
}

# Variable for logging bucket configuration
variable "logging_bucket" {
  description = "Configuration for the logging bucket"
  type = object({
    id     = string
    prefix = optional(string, "")
  })
  default = null
}

# Variable for additional tags
variable "tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

# Variable for SSL enforcement
variable "enforce_ssl" {
  description = "Enforce SSL/TLS for all requests to the bucket"
  type        = bool
  default     = true
}





# S3 Logging Bucket Variables
#
# This file contains variables for configuring an S3 bucket dedicated to logging.
# The logging bucket is configured with:
# - Optional custom bucket naming
# - Server-side encryption (AES256)
# - Lifecycle rules for log retention
# - Required IAM policies for S3 logging
# - Appropriate tags for resource management

# Variable for logging bucket name
variable "logging_bucket_name" {
  description = "Name of the logging bucket. If not provided, will use '<bucket_name>-logs'"
  type        = string
  default      = "my-terraform-logging-bucket-2024"
  
}

# Variable for bucket name (if needed for default logging bucket name)
variable "bucket_name_log" {
  description = "Name of the main bucket - used to generate default logging bucket name"
  type        = string
}

# Variable for log retention period
variable "log_retention_days" {
  description = "Number of days to retain logs before deletion"
  type        = number
  default     = 90  # Example default value
}

# Variable for additional logging bucket tags
variable "logging_bucket_tags" {
  description = "Additional tags for the logging bucket"
  type        = map(string)
  default     = {}
}

# Variable for logging bucket service principal
variable "logging_service_principal" {
  description = "AWS service principal for logging"
  type        = string
  default     = "XXXXXXXXXXXXXXXXXXXXXXXX"  # Standard S3 logging service principal
}
