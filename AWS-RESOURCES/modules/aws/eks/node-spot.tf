locals {
  node_spot = {
    desired_size = 2
    max_size     = 6
    min_size     = 2
  }
}


resource "aws_eks_node_group" "spot" {
  count = var.enable_spot_node_group ? 1 : 0

  node_group_name = format("spot-%s", aws_eks_cluster.eks.name)
  cluster_name    = aws_eks_cluster.eks.name
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = [for value in local.eks_subnets : value]

  instance_types = [
    "m5a.large",
    "m6a.large",
    "m6a.xlarge",
    "c5.large",
    "c5a.large",
  ]

  capacity_type = "SPOT"
  ami_type      = "AL2_x86_64"
  disk_size     = 20

  scaling_config {
    desired_size = local.node_spot.desired_size
    max_size     = local.node_spot.max_size
    min_size     = local.node_spot.min_size
  }

  remote_access {
    ec2_ssh_key               = module.key_pair_spot[0].key_pair_key_name
    source_security_group_ids = [aws_security_group.node.id]
  }

  labels = {
    "eks/cluster-name"   = aws_eks_cluster.eks.name
    "eks/nodegroup-name" = format("spot-%s", aws_eks_cluster.eks.name)
    "lifecycle" = "spot"
  }

  tags = {
    "eks/cluster-name"   = aws_eks_cluster.eks.name
    "eks/nodegroup-name" = format("spot-%s", aws_eks_cluster.eks.name)
    "eks/nodegroup-type" = "managed"
  }

  depends_on = [
    module.key_pair_x86
  ]

}

module "key_pair_spot" {
  count = var.enable_spot_node_group ? 1 : 0

  source   = "../keypair"
  key_name = "${var.cluster_name}-nodes-spot"
  account  = var.organization_name
}
