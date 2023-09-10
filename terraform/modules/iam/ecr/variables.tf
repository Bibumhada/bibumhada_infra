variable "aws_region" {
  default = "ap-northeast-2"
}

variable "repo_arn" {
  description = "ARN of the ECR repository"
  type        = string
# Write the repo_arn in terraform.tfvars and protect it using .gitignore.
# An IAM associated with the specified repo_arn will be created.
}