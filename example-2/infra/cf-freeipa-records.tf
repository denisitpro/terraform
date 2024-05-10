### ipa record for container
resource "cloudflare_record" "ipa_02_aws_A_records" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.freeipa_16_host_data)
  name       = "ipa-02"
  type       = "A"
  ttl        = 300
  value      = module.ec2_vm_euc1_c1_infra.freeipa_16_host_data[count.index].private_ip
  depends_on = [module.ec2_vm_euc1_c1_infra.freeipa_16_host_data]
}

resource "cloudflare_record" "c1_ldap_tcp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_ldap._tcp.${var.c1_infra_general_domain}.}"
  type    = "SRV"

  data {
    service  = "_ldap"
    proto    = "_tcp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 389
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "c1_kerberos_udp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_kerberos._udp.${var.c1_infra_general_domain}.}"
  type    = "SRV"

  data {
    service  = "_kerberos"
    proto    = "_udp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 88
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "c1_kerberos_tcp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_kerberos._tcp.${var.c1_infra_general_domain}.}"
  type    = "SRV"

  data {
    service  = "_kerberos"
    proto    = "_tcp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 88
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "c1_kerberos_master_udp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_kerberos-master._udp.${var.c1_infra_general_domain}.}"
  type    = "SRV"

  data {
    service  = "_kerberos-master"
    proto    = "_udp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 88
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "c_kerberos_master_tcp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_kerberos-master._tcp.${var.c1_infra_general_domain}.}"
  type    = "SRV"

  data {
    service  = "_kerberos-master"
    proto    = "_tcp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 88
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "c_kpasswd_udp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_kpasswd._udp.${var.c1_infra_general_domain}.}"
  type    = "SRV"

  data {
    service  = "_kpasswd"
    proto    = "_udp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 464
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "c_kpasswd_tcp_srv" {
  zone_id = local.current_cf_zone_id
  name    = "_kpasswd._tcp.${var.c1_infra_general_domain}."
  type    = "SRV"

  data {
    service  = "_kpasswd"
    proto    = "_tcp"
    name     = "example.com"
    priority = 0
    weight   = 100
    port     = 464
    target   = "ipa-02.${var.c1_infra_general_domain}"
  }
}

resource "cloudflare_record" "ci_q9_ipa_kerberos" {
  zone_id = local.current_cf_zone_id
  name    = "_kerberos.${var.c1_infra_general_domain}"
  value   = "example.com"
  type    = "TXT"
}