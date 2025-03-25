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

variable "enable_vpn_gateway" {
  default = false
}

variable "subnet_prefix" {
  description = "Prefix length (CIDR mask) for the subnets"
  type        = number
  default     = 24

  validation {
    condition     = var.subnet_prefix >= 16 && var.subnet_prefix <= 28
    error_message = "subnet_prefix must be between 16 and 28"
  }
}