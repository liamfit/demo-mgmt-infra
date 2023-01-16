# terraform-core-infra

This repo contains terraform config and pipelines to manage the AWS management account infrastructure for a given project.

## How do I bootstrap a new AWS account?

The bootstrap directory contains terraform config to create the S3 backend for storing Terraform remote state files and a DynamoDB table for state locking. This is deployed from your local machine so AWS credentials are required for the account you are deploying into. 

Steps are as follows:

1. Comment out the backend config in `main.tf` like this:

```
  # backend "s3" {
  #   key            = "terraform-core-infra/bootstrap/terraform.tfstate"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state"
  # }
```
 
2. Create a copy of `bootstrap\variables.tf` locally called `boostrap\override.tf` and add the region in which you want to create the resources
3. Run `terraform init` and `terraform apply` from within the `bootstrap\` directory
4. Add the value of the output `tf_state_bucket` to repository secrets as `TF_STATE_BUCKET`

Next we need to migrate the local terraform state to the newly created state bucket:

5. Uncomment the backend config in `main.tf`
6. Run `terraform init` and enter the name of the newly created S3 bucket and AWS region when prompted
7. Type `yes` to copy the existing state to the new backend

Finally, we need to create the Github OIDC identity provider, an IAM role that Github Actions will assume when deploying the core infrastructure and an S3 bucket to store Github artifacts (e.g. terraform plans):

8. Create a copy of `variables.tf` locally called `override.tf` and add the region in which you want to create the resources
9. Run `terraform init` and enter the name of the terraform state bucket and AWS region when prompted
10. Run `terraform apply` to create the core infrastructure
11. Add the value of the output `github_artifacts_bucket` to repository secrets as `GH_ARTIFACTS_BUCKET`
12. Add repositiory secrets for `AWS_REGION`, `AWS_ACCOUNT_ID` and `AWS_ROLE` (this will be `Github-Actions-Role` unless modified in `main.tf`)
