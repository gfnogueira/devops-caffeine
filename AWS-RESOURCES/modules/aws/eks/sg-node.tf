resource "aws_security_group" "node" {
  name   = "worker-node-${var.cluster_name}"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_cidr
    description = "Node Ingress Workstation HTTPs"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_cidr_shared
    description = "VPC Shared"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                      = "Worker Nodes Security Group",
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment                                 = var.account_name
    Tenant                                      = var.organization_name
  }
}