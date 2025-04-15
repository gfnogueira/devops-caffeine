variable "cluster_name" {
  description = "Name of EKS cluster"
}

variable "eks_version" {
  description = "Version of EKS cluster. It will be replicated for Worker nodes"
}

variable "eks_ami" {
  description = "AMI to be used for EKS workers"
}

variable "eks_ami_arm64" {
  description = "AMI to be used for EKS workers"
}

variable "default_imdsv2" {
  description = "Controls the requirement of using IMDSv2 for metadata access."
  default = "optional"
}

variable "private_subnets" {
  description = "List of private subnets for the cluster"
}

variable "vpc_id" {
  description = "VPC ID  where EKS will be created in"
}

variable "vpc_cidr" {
  description = "VPC network range"
}

variable "vpc_cidr_vpn" {
  description = "CIDR VPN OnSite"
  type        = list(string)
  default     = []
}

variable "vpc_cidr_shared" {
  description = "VPC network range - Shared"
}


variable "ingress_controller_policy" {
  description = "Policy document for AWS Ingress Controller"
}

variable "cluster_autoscaler_policy" {
  description = "Policy document for EKS cluster autoscaler"
}

variable "kms_deletion_window_in_days" {
  description = "KMS key deletion time"
}

variable "enable_key_rotation" {
  description = "Enable KMS key roation. Valid values: true or false"
  type        = bool
}

variable "eks_addons" {
  type = list(string)
}

variable "general_policy" {}

variable "enable_arm64_node_group" {}

variable "enable_x86_node_group" {}

variable "enable_spot_node_group" {
  default = false
}

variable "spot_max_price" {
  default = "0.04"
}

variable "enable_taints" {
  description = "Flag to enable Kubernetes taints on the node group."
  default     = false
}

variable "organization_name" {}

variable "account_name" {}

variable "scaling_min" {
  default = "2"
}
variable "scaling_max" {
  default = "10"
}
variable "scaling_desired" {
  default = "2"
}

variable "worker_x86_instance_type" {
  description = "EKS worker instance type"
}

variable "worker_x86_volume_size" {
  description = "Disk size for root block device"
}

variable "worker_arm64_instance_type" {
  description = "EKS worker instance type"
}

variable "worker_arm64_volume_size" {
  description = "Disk type for root block device"
}