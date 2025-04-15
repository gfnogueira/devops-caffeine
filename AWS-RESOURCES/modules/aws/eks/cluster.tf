locals {
  eks_subnets = slice(var.private_subnets, 0, 4)
}

resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks.arn
  version  = var.eks_version

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.secrets.arn
    }
  }

  vpc_config {
    security_group_ids      = [aws_security_group.eks.id]
    subnet_ids              = [for value in local.eks_subnets : value]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  tags = {
    Environment = var.account_name
    Tenant      = var.organization_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKSServicePolicy,
  ]
}

resource "aws_eks_addon" "this" {
  count                       = length(var.eks_addons)
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = element(var.eks_addons, count.index)
  addon_version               = data.aws_eks_addon_version.this.*.version[count.index]

  depends_on = [
    aws_eks_node_group.arm64,
    aws_eks_node_group.x86
  ]

}

resource "aws_kms_key" "secrets" {
  description             = "KMS key for EKS secrets encryption"
  deletion_window_in_days = var.kms_deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
}