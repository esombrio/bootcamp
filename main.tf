provider "aws" {
  region = "us-east-1"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "meu_bucket" {
  bucket = "meu-bucket-unico-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "Meu Bucket Único"
    Environment = "Dev"
    CreatedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.meu_bucket.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.meu_bucket.id
  acl    = "private"
}

output "bucket_name" {
  value = aws_s3_bucket.meu_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.meu_bucket.arn
}
