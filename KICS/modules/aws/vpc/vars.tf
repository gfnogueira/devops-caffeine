locals {
  resource_type = "vpc"
  resource_name = var.identifier != null ? format("%s-%s-%s", var.organization_account_name, var.identifier, local.resource_type) : format("%s-%s", var.organization_account_name, local.resource_type)
}

variable "identifier" {
  default     = null
  description = "An optional identifier used to customize resource names."
}

variable "organization_account_name" {
  type        = string
  description = "The name of the organization account, used to prefix resource names."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "destination_logs_arn" {
  default     = null
  description = "The ARN of the destination for VPC flow logs. Optional."
}

variable "cluster_name" {
  default     = "cluster"
  description = "The name of the Kubernetes cluster. Default is 'cluster'."
}