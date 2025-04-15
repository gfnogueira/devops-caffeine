data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

data "aws_ami" "eks-worker-arm64" {
  filter {
    name   = "name"
    values = ["amazon-eks-arm64-node-${var.eks_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}


data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/release_version"
}