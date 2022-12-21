terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }
}

provider "aws" {
  region = var.aws_default_region

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_deployment_role}"
  }
}

resource "aws_s3_bucket" "tf_state_bucket" {
  bucket_prefix = "terraform-state-"
}

resource "aws_s3_bucket_acl" "tf_state_bucket_acl" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_bucket_sse_config" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  rule {
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_versioning" "tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-state" {
  name           = "terraform-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "github_artifacts_bucket" {
  bucket_prefix = "github-artifacts-"
}

resource "aws_s3_bucket_acl" "github_artifacts_bucket_acl" {
  bucket = aws_s3_bucket.github_artifacts_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "github_artifacts_bucket_sse_config" {
  bucket = aws_s3_bucket.github_artifacts_bucket.bucket

  rule {
    bucket_key_enabled = true
  }
}

output "tf_state_bucket" {
  value = aws_s3_bucket.tf_state_bucket.bucket
  description = "Terraform state bucket"
}

output "github_artifacts_bucket" {
  value = aws_s3_bucket.github_artifacts_bucket.bucket
  description = "Github artifacts bucket"
}