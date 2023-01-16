terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }

  backend "s3" {
    key            = "demo-mgmt-infra/bootstrap/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-state"
  }
}