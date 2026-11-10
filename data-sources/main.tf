
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Find Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Find existing Security Group
data "aws_security_group" "public_sg" {
  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Find existing VPC
data "aws_vpc" "my_vpc" {
  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Find existing Subnet
data "aws_subnet" "public_subnet" {
  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Outputs
output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "security_group_id" {
  value = data.aws_security_group.public_sg.id
}

output "vpc_id" {
  value = data.aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = data.aws_subnet.public_subnet.id
}

# Create EC2 Instance
resource "aws_instance" "ec2_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id              = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [data.aws_security_group.public_sg.id]

  tags = {
    email = "nischitpantha@gmail.com"
  }
}
