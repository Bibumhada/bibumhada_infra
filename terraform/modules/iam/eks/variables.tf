variable "aws_region" {
  default = var.aws_region
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "todays-menu-eks-cluster"
}


variable "node_name" {
  description = "The name of the EKS cluster node"
  type        = string
  default     = "todays-menu-eks-node"
}
