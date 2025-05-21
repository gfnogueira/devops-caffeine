locals {
  s3 = {
    name = format("%s-%s", local.resource_name, var.name)
  }
}

resource "aws_s3_bucket" "website" {
  bucket = local.s3.name

  tags = {
    Environment = var.environment
    Tenant = var.organization_account_name
  }
}

resource "aws_s3_bucket_accelerate_configuration" "website" {
  bucket = aws_s3_bucket.website.id
  status = "Enabled"
}

resource "aws_s3_bucket_versioning" "website" {
  
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status     = var.website_versioning_status
    mfa_delete = var.website_versioning_mfa_delete
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy.json
}