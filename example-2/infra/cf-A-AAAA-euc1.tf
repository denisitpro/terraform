resource "cloudflare_record" "mgmt_c1_infra_euc1_admins_A_ipv4" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.mgmt_host_data)
  name       = module.ec2_vm_euc1_c1_infra.mgmt_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.mgmt_host_data[count.index].private_ip
  type       = "A"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.mgmt_host_data]
}

resource "cloudflare_record" "mgmt_c1_infra_euc1_admins_A_ipv6" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.mgmt_host_data)
  name       = module.ec2_vm_euc1_c1_infra.mgmt_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.mgmt_host_data[count.index].ipv6_addresses[0]
  type       = "AAAA"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.mgmt_host_data]
}

resource "cloudflare_record" "nginx_15_c1_infra_euc1_A_ipv4" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.nginx_15_host_data)
  name       = module.ec2_vm_euc1_c1_infra.nginx_15_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.nginx_15_host_data[count.index].private_ip
  type       = "A"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.nginx_15_host_data]
}

#resource "cloudflare_record" "nginx_15_c1_infra_euc1_A_ipv6" {
#  zone_id    = local.current_cf_zone_id
#  count      = length(module.ec2_vm_euc1_c1_infra.nginx_15_host_data)
#  name       = module.ec2_vm_euc1_c1_infra.nginx_15_host_data[count.index].name
#  value      = module.ec2_vm_euc1_c1_infra.nginx_15_host_data[count.index].ipv6_addresses[0]
#  type       = "AAAA"
#  proxied    = false
#  depends_on = [module.ec2_vm_euc1_c1_infra.nginx_15_host_data]
#}

resource "cloudflare_record" "grafana_15_c1_infra_euc1_A_ipv4" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.grafana_15_host_data)
  name       = module.ec2_vm_euc1_c1_infra.grafana_15_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.grafana_15_host_data[count.index].private_ip
  type       = "A"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.grafana_15_host_data]
}

resource "cloudflare_record" "grafana_15_c1_infra_euc1_A_ipv6" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.grafana_15_host_data)
  name       = module.ec2_vm_euc1_c1_infra.grafana_15_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.grafana_15_host_data[count.index].ipv6_addresses[0]
  type       = "AAAA"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.grafana_15_host_data]
}

resource "cloudflare_record" "runner_15_c1_infra_euc1_ipv4" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.runner_15_host_data)
  name       = module.ec2_vm_euc1_c1_infra.runner_15_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.runner_15_host_data[count.index].private_ip
  type       = "A"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.runner_15_host_data]
}

resource "cloudflare_record" "runner_15_c1_infra_euc1_ipv6" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_infra.runner_15_host_data)
  name       = module.ec2_vm_euc1_c1_infra.runner_15_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_infra.runner_15_host_data[count.index].ipv6_addresses[0]
  type       = "AAAA"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_infra.runner_15_host_data]
}
