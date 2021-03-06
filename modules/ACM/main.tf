provider "aws" {
    region = var.AWS_REGION
    access_key = var.instance_accesskey
    secret_key = var.instance_secretkey
}
resource "aws_acm_certificate" "example" {
  domain_name       = var.domain
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.domain}"]
}

data "aws_route53_zone" "example" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_route53_record" "new_record2" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = "static.terraformcloudfront.tk"
  type    = "A"
  alias {
    name = var.domain_name
    zone_id = var.zone_id
    evaluate_target_health = false
  }
  
}


resource "aws_route53_record" "new_record" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = "media.terraformcloudfront.tk"
  type    = "A"
  alias {
    name = var.domain_name
    zone_id = var.zone_id
    evaluate_target_health = false
  }

}



resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

