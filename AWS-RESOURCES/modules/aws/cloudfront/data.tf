data "aws_acm_certificate" "selected" {
  format("*.%s.%s", var.website_config["route53_record_name"])
}

data "aws_route53_zone" "selected" {
  name = var.website_config["domain_name"]
}
