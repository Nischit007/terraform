
variable "region" {
  description = "I want to craete ec2 instance for testing porpose"
  default = "us-east-1"
  type = string
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "himali.tech-tranning-bucket-batch-1-v2"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}



