provider "aws" {
  region = var.aws_region
}

# IAM
resource "aws_iam_user" "ecr_user" {
  name = "todays-ecr-access-user"
  path = "/system/"
}

resource "aws_iam_access_key" "ecr_user_key" {
  user = aws_iam_user.ecr_user.name
}

resource "aws_iam_user_policy" "ecr_access_policy" {
  name = "ECRAccessPolicy"
  user = aws_iam_user.ecr_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = [var.repo_arn]
      }
    ]
  })
}