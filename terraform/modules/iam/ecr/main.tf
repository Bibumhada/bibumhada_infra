provider "aws" {
  region = var.aws_region
}

# IAM
resource "aws_iam_user" "ecr_user" {
  name = "todays-menu-ecr-access-user"
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
          "ecr:GetAuthorizationToken", //
          "ecr:GetDownloadUrlForLayer", //
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability", //
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:PutImage", //
          "ecr:InitiateLayerUpload", //
          "ecr:UploadLayerPart", //
          "ecr:CompleteLayerUpload", //
        ],
        // If you intend to use this IAM account for GitHub Actions, you should grant permissions to all repositories.
        Resource = "*"
        //It's more appropriate to create a dedicated IAM for GitHub Actions and grant permissions only to specific repositories as shown below.
      #  Resource = [var.repo_arn]
      }
    ]
  })
}