output "name" {
  value = aws_eks_cluster.eks.name
}

output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "ca" {
  value = aws_eks_cluster.eks.certificate_authority.0.data
}

output "version" {
  value = aws_eks_cluster.eks.version
}

output "worker_sg" {
  value = aws_security_group.node.id
}

output "worker_iam_role" {
  value = aws_iam_role.node.arn
}

output "config_map" {
  value = local.config_map_aws_auth
}

output "aws_iam_openid_connect_provider" {
  value = aws_iam_openid_connect_provider.this
}