provider "aws" {
  region = var.aws_region
}

module "oidc_github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.1.1"

  attach_admin_policy = true
  iam_role_name       = "Github-Actions-Role"

  github_repositories = [
    "liamfit/terraform-core-infra"
  ]
}

module "s3_bucket_github" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket_prefix = "github-artifacts-"
  acl           = "private"

  versioning = {
    enabled = true
  }

}