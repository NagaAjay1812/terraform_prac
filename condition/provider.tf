terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # It is best practice to pin your provider version
    }
  }
}
# Configure the AWS provider with a specific region
provider "aws" {
  region = "us-east-1"
}
