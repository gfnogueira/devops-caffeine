resource "aws_acm_certificate" "this" {
  domain_name               = format("*.%s", var.domain_name)
  subject_alternative_names = [var.domain_name]
  validation_method         = var.validation_method

  tags = {
    Environment = var.account_name
    Tenant = var.organization_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "this" {

  for_each = {
    for resource_value in aws_acm_certificate.this.domain_validation_options : resource_value.domain_name => {
      name   = resource_value.resource_record_name
      type   = resource_value.resource_record_type
      record = resource_value.resource_record_value

    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.certificate_validation_ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.selected.zone_id
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}
