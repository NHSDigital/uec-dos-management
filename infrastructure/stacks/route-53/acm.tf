module "acm_certificate" {
  source      = "../../modules/acm"
  domain_name = "uec-capacity-management.nhs.uk"
  zone_id     = module.cm_route53.zone_id
  san_list    = ["*.uec-capacity-management.nhs.uk"]

  tags = {
    Environment = "production"
    Owner       = "dos-rewrite"
  }
}

output "certificate_arn" {
  value = module.acm_certificate.certificate_arn
}
