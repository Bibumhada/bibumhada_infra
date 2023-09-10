provider "aws_region" {
  default = var.aws_region
}

resource "aws_iam_role" "eks_cluster" {
  name = var.cluster_name

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "eks_node" {
  name = var.node_name

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

locals {
  common_policies = {
    eks_cluster = [
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    ],
    eks_node = [
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policies" {
  for_each   = toset(local.common_policies.eks_cluster)
  policy_arn = each.value
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_node_policies" {
  for_each   = toset(local.common_policies.eks_node)
  policy_arn = each.value
  role       = aws_iam_role.eks_node.name
}
