data "cloudflare_zone" "current_cf_zone_id" {
  name = "example-prod.com"
}

locals {
  current_cf_zone_id   = data.cloudflare_zone.current_cf_zone_id.zone_id
  current_cf_zone_name = data.cloudflare_zone.current_cf_zone_id.name

}

output "dns_zone_id" {
  value = local.current_cf_zone_id
}