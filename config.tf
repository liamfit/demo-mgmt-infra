terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }

  backend "s3" {
    region         = "us-east-1"
    key            = "state/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }
}

provider "aws" {
  region = var.aws_default_region

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_deployment_role}"
  }
}
