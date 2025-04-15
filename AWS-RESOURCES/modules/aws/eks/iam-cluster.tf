resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.this.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.this_assume_role_policy.json
  name               = "WebID-${var.cluster_name}"
}

resource "aws_iam_role" "eks" {
  name               = "eks-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH

apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

#locals {
#  workers_userdata = <<USERDATA
##!/bin/bash
#set -o xtrace
#/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' '${var.cluster_name}'
#USERDATA
#}

locals {
  workers_userdata = <<USERDATA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: ${aws_eks_cluster.eks.endpoint}
    certificateAuthority: ${aws_eks_cluster.eks.certificate_authority.0.data}
    cidr: ${data.aws_eks_cluster.eks_cluster.kubernetes_network_config[0].service_ipv4_cidr}
    name: ${aws_eks_cluster.eks.name}

--//--
USERDATA
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_policy" "ingress_controller" {
  name        = "ingress-controller-${var.cluster_name}"
  path        = "/"
  description = "AWS Ingress Controller Policy"

  policy = file(var.ingress_controller_policy)
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "cluster-autoscaler-${var.cluster_name}"
  path        = "/"
  description = "EKS cluster autoscaler policy"

  policy = file(var.cluster_autoscaler_policy)
}

resource "aws_iam_policy" "general" {
  name = "eks_worker_ec2_policy-${var.cluster_name}"
  path = "/"

  policy = file(var.general_policy)
}