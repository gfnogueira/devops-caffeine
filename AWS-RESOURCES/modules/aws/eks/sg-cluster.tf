resource "aws_security_group" "eks" {
  name   = "eks-${var.cluster_name}"
  vpc_id = var.vpc_id


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_cidr
    description = "Allow workstation to communicate with the cluster API Server"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_cidr_shared
    description = "VPC Shared"
  }

  dynamic "ingress" {
    for_each = length(var.vpc_cidr_vpn) > 0 ? [1] : []
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = var.vpc_cidr_vpn
      description = "CIDR VPN OnSite"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "EKS Control Plane"
    Tenant = var.organization_name
  }
}