resource "cloudflare_record" "ci_prod_com_caa_specific" {
  zone_id = local.current_cf_zone_id
  name    = local.current_cf_zone_name
  type    = "CAA"
  data {
    flags = "0"
    tag   = "issue"
    value = "letsencrypt.org"
  }
}

resource "cloudflare_record" "ci_prod_com_caa_wildcard" {
  zone_id = local.current_cf_zone_id
  name    = local.current_cf_zone_name
  type    = "CAA"
  data {
    flags = "0"
    tag   = "issuewild"
    value = "letsencrypt.org"
  }
}

resource "cloudflare_record" "ci_prod_com_caa_mail_report" {
  zone_id = local.current_cf_zone_id
  name    = local.current_cf_zone_name
  type    = "CAA"
  data {
    flags = "0"
    tag   = "iodef"
    value = "mailto:devops@example.com"
  }
}