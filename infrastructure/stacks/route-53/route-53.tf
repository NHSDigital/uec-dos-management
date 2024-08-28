module "cm_route53" {
  source    = "../../modules/route-53"
  zone_name = "uec-capacity-management.nhs.uk"
  comment   = "Hosted zone for uec-capacity-management.nhs.uk"
}

output "zone_id" {
  value = module.cm_route53.zone_id
}

output "zone_name" {
  value = module.cm_route53.zone_name
}
