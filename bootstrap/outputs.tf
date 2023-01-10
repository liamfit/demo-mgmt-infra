output "tf_state_bucket" {
  description = "Terraform state bucket"
  value       = aws_s3_bucket.tf_state_bucket.bucket
}