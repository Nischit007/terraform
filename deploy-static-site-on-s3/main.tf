
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

# Create S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "himali.tech-tranning-bucket-batch-1-v3"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# Disable Block Public Access at bucket level
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Configure S3 Bucket Policy
resource "aws_s3_bucket_policy" "allow_access_for_static_site" {
  bucket = aws_s3_bucket.s3_bucket.id

  depends_on = [
    aws_s3_bucket_public_access_block.example
  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Configure S3 Static Website Hosting
resource "aws_s3_bucket_website_configuration" "website_html" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# Upload HTML
resource "aws_s3_object" "html" {
  bucket       = aws_s3_bucket.s3_bucket.id
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

# Upload CSS
resource "aws_s3_object" "style" {
  bucket       = aws_s3_bucket.s3_bucket.id
  source       = "./style.css"
  key          = "style.css"
  content_type = "text/css"
}

# Output Website Endpoint
output "endpoint_name" {
  value = "http://${aws_s3_bucket_website_configuration.website_html.website_endpoint}"
}
