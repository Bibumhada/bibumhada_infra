variable "aws_region" {
  default = "ap-northeast-2"
}

variable "repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "todays-menu"
}