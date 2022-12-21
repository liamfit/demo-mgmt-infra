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
    bucket         = "terraform-state-20221220164019831100000001"
  }
}

provider "aws" {
  region = var.aws_default_region
}
