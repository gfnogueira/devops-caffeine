locals {
  resource_type = "vpn"
  resource_name = format("%s-%s", var.organization_account_name, local.resource_type)
}

variable "identifier" {
  default = null
  type    = string
}

variable "organization_account_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "customer_gateway_settings" {}

variable "private_route_table_id" {
  type = string
}

variable "public_route_table_id" {
  type = string
}

variable "vpn_connection_settings" {}


variable "tunnel1_preshared_key" {
  default = null
}

variable "tunnel1_ike_versions" {
  default = null
}

variable "tunnel1_phase1_encryption_algorithms" {
  default = null
}

variable "tunnel1_phase1_integrity_algorithms" {
  default = null
}

variable "tunnel1_phase1_lifetime_seconds" {
  default = null
}

variable "tunnel1_phase1_dh_group_numbers" {
  default = null
}

variable "tunnel1_dpd_timeout_action" {
  default = null
}

variable "tunnel1_phase2_encryption_algorithms" {
  default = null
}

variable "tunnel1_phase2_integrity_algorithms" {
  default = null
}

variable "tunnel1_phase2_lifetime_seconds" {
  default = null
}

variable "tunnel1_phase2_dh_group_numbers" {
  default = null
}

variable "aws_vpn_gateway" {
  type = string
}

variable "tunnel2_dpd_timeout_action" {
  default = "clear"
}

variable "tunnel2_ike_versions" {
  default = ["ikev2"]
}

variable "tunnel2_phase1_dh_group_numbers" {
  default = ["2"]
}

variable "tunnel2_phase1_encryption_algorithms" {
  default = ["AES256"]
}

variable "tunnel2_phase1_integrity_algorithms" {
  default = ["SHA2-256"]
}

variable "tunnel2_phase1_lifetime_seconds" {
  default = "28800"
}

variable "tunnel2_phase2_dh_group_numbers" {
  default = ["5"]
}

variable "tunnel2_phase2_encryption_algorithms" {
  default = ["AES256"]
}

variable "tunnel2_phase2_integrity_algorithms" {
  default = ["SHA2-256"]
}

variable "tunnel2_phase2_lifetime_seconds" {
  default = "3600"
}

variable "tunnel2_startup_action" {
  default = "add"
}
