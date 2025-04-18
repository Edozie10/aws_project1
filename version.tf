terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" #Allow any 5.x.x version, but not 6.0.0 or higher
      version = "~> 5.0"
    }
  }
}
