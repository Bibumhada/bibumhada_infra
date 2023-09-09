provider "aws" {
  region = var.region
}

# ECR module
module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.repo_name
}

# IAM - ECR
module "iam_ecr" {
  source   = "./modules/iam/ecr"
  repo_arn = module.ecr.ecr_arn
}