
/* Alias section */
resource "cloudflare_record" "mgmt_c1_prod_apne1_admins_CNAME_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.mgmt_c1_prod_apne1_admins_A_ipv4)
  name       = "mgmt-50"
  value      = cloudflare_record.mgmt_c1_prod_apne1_admins_A_ipv4[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.mgmt_c1_prod_apne1_admins_A_ipv4]
}


resource "cloudflare_record" "srv_01_c1_prod_apne1_CNAME_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.srv_01_c1_prod_apne1_A_records)
  name       = "srv-51"
  value      = cloudflare_record.srv_01_c1_prod_apne1_A_records[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.srv_01_c1_prod_apne1_A_records]
}
