resource "aws_eks_node_group" "arm64" {
  count                = var.enable_arm64_node_group ? 1 : 0
  cluster_name         = aws_eks_cluster.eks.name
  node_group_name      = "node_group_arm64-${var.cluster_name}"
  node_role_arn        = aws_iam_role.node.arn
  subnet_ids           = [for value in local.eks_subnets : value]
  force_update_version = true

  launch_template {
    id      = aws_launch_template.node_arm64.id
    version = aws_launch_template.node_arm64.latest_version
  }

  scaling_config {
    desired_size = var.scaling_desired
    max_size     = var.scaling_max
    min_size     = var.scaling_min
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  update_config {
    max_unavailable_percentage = 100
  }

  dynamic "taint" {
    for_each = var.enable_taints ? [1] : []
    content {
      key    = "node-type"
      value  = "ondemand"
      effect = "NO_SCHEDULE"
    }
  }

  labels = {
    "eks/cluster-name"   = aws_eks_cluster.eks.name
    "eks/nodegroup-name" = format("ondemand-arm64-%s", aws_eks_cluster.eks.name)
    "lifecycle" = "ondemand"
  }

  tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "TRUE"
    Arch                                            = "arm64"
    Environment                                     = var.account_name
    Tenant                                          = var.organization_name
  }


  depends_on = [
    aws_iam_role_policy_attachment.Node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.Node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.Node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_launch_template" "node_arm64" {
  name                   = "worker-nodes-arm64-${var.cluster_name}"
  image_id               = var.eks_ami_arm64
  instance_type          = var.worker_arm64_instance_type
  key_name               = module.key_pair_arm64.key_pair_key_name
  vpc_security_group_ids = [aws_security_group.node.id]
  ebs_optimized          = true
  user_data              = base64encode(local.workers_userdata)

  metadata_options {
    http_put_response_hop_limit = 2
    http_tokens                 = var.default_imdsv2
  }


  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.worker_arm64_volume_size
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }

  depends_on = [
    module.key_pair_arm64
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-worker-arm64"
    }
  }
}

module "key_pair_arm64" {
  source   = "../keypair"
  key_name = "${var.cluster_name}-nodes-arm64"
  account  = var.organization_name
}

resource "aws_eks_node_group" "x86" {
  count                = var.enable_x86_node_group ? 1 : 0
  cluster_name         = aws_eks_cluster.eks.name
  node_group_name      = "node_group_x86-${var.cluster_name}"
  node_role_arn        = aws_iam_role.node.arn
  subnet_ids           = [for value in local.eks_subnets : value]
  force_update_version = true

  launch_template {
    id      = aws_launch_template.node_x86.id
    version = aws_launch_template.node_x86.latest_version
  }


  scaling_config {
    desired_size = var.scaling_desired
    max_size     = var.scaling_max
    min_size     = var.scaling_min
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  update_config {
    max_unavailable_percentage = 100
  }

  dynamic "taint" {
    for_each = var.enable_taints ? [1] : []
    content {
      key    = "node-type"
      value  = "ondemand"
      effect = "NO_SCHEDULE"
    }
  }

  labels = {
    "eks/cluster-name"   = aws_eks_cluster.eks.name
    "eks/nodegroup-name" = format("ondemand-x86-%s", aws_eks_cluster.eks.name)
    "lifecycle" = "ondemand"
  }

  tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "TRUE"
    Arch                                            = "x86_64"
    Environment                                     = var.account_name
    Tenant                                          = var.organization_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.Node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.Node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.Node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_launch_template" "node_x86" {
  name                   = "worker-nodes-x86-${var.cluster_name}"
  image_id               = var.eks_ami
  instance_type          = var.worker_x86_instance_type
  key_name               = module.key_pair_x86.key_pair_key_name
  vpc_security_group_ids = [aws_security_group.node.id]
  ebs_optimized          = true
  user_data              = base64encode(local.workers_userdata)

  metadata_options {
    http_put_response_hop_limit = 2
    http_tokens                 = var.default_imdsv2
  }  

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.worker_x86_volume_size
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }

  depends_on = [
    module.key_pair_x86
  ]


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-worker-x86"
    }
  }
}

module "key_pair_x86" {
  source   = "../keypair"
  key_name = "${var.cluster_name}-nodes-x86-64"
  account  = var.organization_name
}