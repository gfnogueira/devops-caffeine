locals {
  resource_type = "s3"
  resource_name = format("%s-%s", var.organization_account_name, local.resource_type)
}

variable "name" {
  description = "Name of the resource"
  default     = "default-name"
}

variable "organization_account_name" {
  description = "Organization account name"
}

variable "environment" {
  description = "Environment for the resource"
}

variable "price_class" {
  default = "PriceClass_100"
}

variable "bucket_acl" {
  default = "private"
}

variable "versioning_enabled" {
  default = "true"
}

variable "lifecycle_rule" {
  description = "Lifecycle rule for bucket"
  default     = null
}

variable "noncurrent_version_transition" {
  description = "Non-current version transition"
  default     = null
}

variable "policy" {
  default = null
}

variable "website_config" {
  description = "Website configuration including domain and record name"
  default = {
    domain_name         = "site-name"
    route53_record_name = "www"
  }
}

variable "web_acl_id" {
  default = null
}

variable "response_headers_policy_id" {
  description = "Response headers policy ID"
  default     = null
}

variable "website_versioning_status" {
  description = "(Optional) The versioning state of the bucket. Valid values: Enabled or Suspended. Defaults to Enabled"
  type        = string
  default     = "Enabled"
}

variable "website_versioning_mfa_delete" {
  description = "(Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: Enabled or Disabled. Defaults to Disabled"
  type        = string
  default     = "Disabled"
}

variable "website_cors_allowed_headers" {
  description = "(Optional) Specifies which headers are allowed. Defaults to Authorization and Content-Length"
  type        = list(string)
  default     = ["Authorization", "Content-Length"]
}

variable "website_cors_allowed_methods" {
  description = "(Optional) Specifies which methods are allowed. Can be GET, PUT, POST, DELETE or HEAD. Defaults to GET and POST"
  type        = list(string)
  default     = ["GET", "POST"]
}

variable "website_cors_expose_headers" {
  description = "(Optional) Specifies expose header in the response."
  type        = list(string)
  default     = []
}

variable "website_cors_max_age_seconds" {
  description = "(Optional) Specifies time in seconds that browser can cache the response for a preflight request. Defaults to 3600"
  type        = number
  default     = 3600
}

variable "website_cors_additional_allowed_origins" {
  description = "(Optional) Specifies which origins are allowed besides the domain name specified"
  type        = list(string)
  default     = []
}

variable "www_website_bucket_acl" {
  description = "(Optional) The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private."
  type        = string
  default     = "private"
}

variable "website_bucket_acl" {
  description = "(Optional) The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private."
  type        = string
  default     = "public-read"
}

variable "custom_error_response_403" {
  description = "(Optional) Custom error response for HTTP 403 errors"
  type        = string
  default     = "403.html"
}

variable "custom_error_response_404" {
  description = "(Optional) Custom error response for HTTP 404 errors"
  type        = string
  default     = "404.html"
}

variable "alb_origin_domain_name" {
  description = "ALB Origin domain name to redirect"
  type        = string
  default     = "alb.example.com"
}

