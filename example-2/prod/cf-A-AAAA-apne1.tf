resource "cloudflare_record" "mgmt_c1_prod_apne1_admins_A_ipv4" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_apne1_c1_prod.mgmt_host_data)
  name       = module.ec2_vm_apne1_c1_prod.mgmt_host_data[count.index].name
  value      = module.ec2_vm_apne1_c1_prod.mgmt_host_data[count.index].private_ip
  type       = "A"
  proxied    = false
  depends_on = [module.ec2_vm_apne1_c1_prod.mgmt_host_data]
}

resource "cloudflare_record" "mgmt_c1_prod_apne1_admins_AAAA_ipv6" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_apne1_c1_prod.mgmt_host_data)
  name       = module.ec2_vm_apne1_c1_prod.mgmt_host_data[count.index].name
  value      = module.ec2_vm_apne1_c1_prod.mgmt_host_data[count.index].ipv6_addresses[0]
  type       = "AAAA"
  proxied    = false
  depends_on = [module.ec2_vm_apne1_c1_prod.mgmt_host_data]
}

