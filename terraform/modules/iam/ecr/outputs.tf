output "ecr_user_name" {
  description = "IAM user name for ECR"
  value       = aws_iam_user.ecr_user.name
}

output "ecr_user_access_key" {
  description = "IAM user access key ID for ECR"
  value       = aws_iam_access_key.ecr_user_key.id
  sensitive = true # ex) terraform output -raw ecr_user_access_key

}

output "ecr_user_secret_key" {
  description = "IAM user secret access key for ECR"
  value       = aws_iam_access_key.ecr_user_key.secret
  sensitive = true # terraform output -raw ecr_user_secret_key
}
