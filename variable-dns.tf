data "cloudflare_zone" "current_cf_zone_id" {
  name = "example.com"
}

locals {
  current_cf_zone_id = data.cloudflare_zone.current_cf_zone_id.zone_id
}

output "dns_zone_id" {
  value = local.current_cf_zone_id
}