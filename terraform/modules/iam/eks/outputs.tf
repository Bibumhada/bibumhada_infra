# outputs.tf
output "eks_cluster_role_arn" {
  description = "The ARN of the role for the EKS cluster."
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  description = "The ARN of the role for the EKS worker nodes."
  value       = aws_iam_role.eks_node.arn
}