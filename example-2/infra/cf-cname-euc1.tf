/* section Frankfurt */
resource "cloudflare_record" "mgmt_c1_prod_euc1_admins_CNAME_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.mgmt_c1_infra_euc1_admins_A_ipv4)
  name       = "mgmt-${format("%02d", count.index + 15)}"
  value      = cloudflare_record.mgmt_c1_infra_euc1_admins_A_ipv4[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.mgmt_c1_infra_euc1_admins_A_ipv4]
}

resource "cloudflare_record" "grafana_15_c1_infra_CNAME" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.grafana_15_c1_infra_euc1_A_ipv4)
  name       = "grafana-${format("%02d", count.index + 15)}"
  value      = cloudflare_record.grafana_15_c1_infra_euc1_A_ipv4[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.grafana_15_c1_infra_euc1_A_ipv4]
}

resource "cloudflare_record" "nginx_general_c1_infra_CNAME_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4)
  name       = "nginx-${format("%02d", count.index + 15)}"
  value      = cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4]
}