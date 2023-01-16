provider "aws" {
  region = var.aws_region
}

module "s3_bucket_terraform_state" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket_prefix = "terraform-state-"
  acl           = "private"

  versioning = {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_state" {
  name           = "terraform-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
