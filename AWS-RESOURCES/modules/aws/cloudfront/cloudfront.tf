locals {
  s3_origin_id = "S3-${local.s3.name}"
  cloudfront-authentication-user-agent = "ua${local.s3_origin_id}"
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = local.s3_origin_id
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name         = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id           = local.s3_origin_id
    connection_timeout  = 10
    connection_attempts = 3
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }

  }

  enabled         = true
  is_ipv6_enabled = true
  price_class     = var.price_class
  web_acl_id      = var.web_acl_id

  aliases = [format("%s.%s", var.website_config["route53_record_name"])]

  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

      headers = ["Origin"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true

    response_headers_policy_id = var.response_headers_policy_id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.selected.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
        error_caching_min_ttl = 10
        error_code            = 403
        response_code         = 200
        response_page_path    = var.custom_error_response_403
  }

  custom_error_response {
        error_caching_min_ttl = 10
        error_code            = 404
        response_code         = 200
        response_page_path    = var.custom_error_response_404
  }

  tags = {
    Environment = var.environment
    Tenant = var.organization_account_name
  }
}



