output "tf_state_bucket" {
  description = "Terraform state bucket"
  value       = module.s3_bucket_terraform_state.s3_bucket_id
}