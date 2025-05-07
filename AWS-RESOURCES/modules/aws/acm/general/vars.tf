variable "domain_name" {
  type = string
}

variable "validation_method" {
  type    = string
  default = "DNS"
}

variable "certificate_validation_ttl" {
  type    = string
  default = "60"
}

variable organization_name {}

variable account_name {}