# terraform-aws-infra

This repo contains terraform config and pipelines to create the aws infrastructure for public API Gateway endpoint linked to a private Application Load Balancer with an ECS Fargate cluster behind it.

## How do I deploy to a new AWS account?

There are some manual steps to set up the terraform backend config and connection from Github to AWS. You will need an AWS access key/secret key for a user that has permissions to assume a role that can create S3 buckets and DynamoDB tables.

1. Create a copy of `backend\variables.tf` locally called `backend\override.tf` and add the AWS account ID, region and IAM role to use with the terraform AWS provider
2. Run `terraform init` and `terraform apply` from within the `backend\` directory. This will create S3 buckets for terraform remote state and Github artifacts and a DynamoDB table for terraform state locking
3. Add the value of the output `github_artifacts_bucket` to repository secrets as `GH_ARTIFACTS_BUCKET`
4. Add the value of the output `tf_state_bucket` to repository secrets as `TF_STATE_BUCKET`
5. Configure Github as an OIDC identity provider in AWS (see [docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services))
6. Add repositiory secrets for `AWS_DEFAULT_REGION`, `AWS_INFRA_ACCOUNT_ID` and `AWS_INFRA_ACCOUNT_ROLE` (this is the role you created for Github to assume in step 5)
