terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# Create S3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "himali.tech-tranning-bucket-batch-1-v1"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "myfile" {
    bucket = aws_s3_bucket.s3_bucket.bucket
    source = "./hello.txt"
    key ="hi.txt"
}   