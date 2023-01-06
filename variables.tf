variable "application_repo" {
  type    = string
  default = "sample-app"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0e773070b80f39124"
}
variable "private_subnets" {
  type = list(any)
  default = [
    "subnet-011befea65be68a01",
    "subnet-05b1705e0933071f9"
  ]
}
