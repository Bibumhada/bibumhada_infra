output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.ecr_repository_url
}

output "ecr_user_name" {
  description = "IAM user name for ECR"
  value       = module.iam_ecr.ecr_user_name
}

output "ecr_user_access_key" {
  description = "IAM user access key ID for ECR"
  value       = module.iam_ecr.ecr_user_access_key
}
