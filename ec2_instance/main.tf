# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.0"
#     }
#   }
# }

# # Configure the AWS Provider
# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "example" {
#   ami           = "ami-0d97d7f07b25dd693"
#   instance_type = "t3.micro"

#   tags = {
#     email = "nischitpantha@gmail.com"
#   }
# }




# ===========================================================================================================================================================
# Create ec2 instance using variable

# variable "region" {
#   description = "I want to craete ec2 instance for testing porpose"
#   default = "us-east-1"
#   type = string
# }



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
  region = var.region
}

resource "aws_instance" "ec2_server" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.micro"

  tags = {
    email = "nischitpantha@gmail.com"
  }
}

resource "aws_s3_object" "myfile" {
    source = "./hello.txt"
    key ="hi.txt"
}   