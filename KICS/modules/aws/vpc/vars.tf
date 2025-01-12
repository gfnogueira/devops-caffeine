locals {
  resource_type = "vpc"
  resource_name = var.identifier != null ? format("%s-%s-%s", var.organization_account_name, var.identifier, local.resource_type) : format("%s-%s", var.organization_account_name, local.resource_type)
}

variable "identifier" {
  default = null
}
variable "organization_account_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "destination_logs_arn" {
  default = null
}

variable "cluster_name" {
  default = "cluster"
}
