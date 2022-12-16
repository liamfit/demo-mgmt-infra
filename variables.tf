variable "aws_account_id" {
  type    = string
  default = "629239571689"
}

variable "aws_default_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_deployment_role" {
  type    = string
  default = "OrganizationAccountAccessRole"
}

variable "application_repo" {
  type    = string
  default = "liamfit/sample-app"  
}

variable "vpc_id" {
  type    = string
  default = "vpc-0e773070b80f39124"
}
variable "private_subnets" {
  type    = list(any)
  default = [
      "subnet-011befea65be68a01",
      "subnet-05b1705e0933071f9"
  ]
}