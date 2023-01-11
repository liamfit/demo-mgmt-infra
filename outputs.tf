output "github-artifacts-bucket" {
    description = "The name of the github artifacts bucket"
    value       = module.s3_bucket_github.s3_bucket_id
}