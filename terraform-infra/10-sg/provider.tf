terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # It is best practice to pin your provider version
    }
  }
  backend "s3" {
    bucket       = "joindevops-remotestate-terr-infra"
    key          = "10-sg.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
# Configure the AWS provider with a specific region
provider "aws" {
  region = "us-east-1"
}
