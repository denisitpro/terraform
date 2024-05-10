/* manual publish A record and cname */
resource "cloudflare_record" "grafana_aws_c1_infra_CNAME_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4)
  name       = "grafana-aws"
  value      = cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4]
}

resource "cloudflare_record" "ipa_aws_c1_infra_CNAME_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4)
  name       = "ipa-aws"
  value      = cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4[count.index].hostname
  type       = "CNAME"
  proxied    = false
  depends_on = [cloudflare_record.nginx_15_c1_infra_euc1_A_ipv4]
}
