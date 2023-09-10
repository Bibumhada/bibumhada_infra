provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "ecr_repo" {
  name = var.repo_name

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = jsonencode({
    "rules": [
      {
        "rulePriority": 1,
        "description": "Never expire prod images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["prod-"],
          "countType": "imageCountMoreThan",
          "countNumber": 1000
        },
        "action": {
          "type": "expire"
        }
      },
      {
        "rulePriority": 2,
        "description": "Expire dev images after 7 days",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["dev-"],
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 7
        },
        "action": {
          "type": "expire"
        }
      },
      {
        "rulePriority": 3,
        "description": "Retain only 10 untagged images",
        "selection": {
          "tagStatus": "untagged",
          "countType": "imageCountMoreThan",
          "countNumber": 10
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  })
}
