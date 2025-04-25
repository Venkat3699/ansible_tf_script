terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.93.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-s3-bucket-123" # Replace with your S3 bucket name
    key     = "terraform.tfstate"       # Path to store the state file
    region  = "ap-south-1"              # AWS region
    encrypt = true                      # Encrypt state file
    # dynamodb_table = "terraform-state-lock"          # DynamoDB table for state locking
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
