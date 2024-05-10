resource "cloudflare_record" "model_400_c1_prod_euc1_A_ipv4" {
  zone_id    = local.current_cf_zone_id
  count      = length(module.ec2_vm_euc1_c1_prod.model_400_host_data)
  name       = module.ec2_vm_euc1_c1_prod.model_400_host_data[count.index].name
  value      = module.ec2_vm_euc1_c1_prod.model_400_host_data[count.index].private_ip
  type       = "A"
  proxied    = false
  depends_on = [module.ec2_vm_euc1_c1_prod.model_400_host_data]
}
