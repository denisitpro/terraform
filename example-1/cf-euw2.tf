#resource "cloudflare_record" "mgmt_c99_devops_euw2_admins_A_records" {
#  zone_id    = local.current_cf_zone_id
#  count      = length(module.ec2_vm_euw2_c99_devops.mgmt_host_data)
#  name       = module.ec2_vm_euw2_c99_devops.mgmt_host_data[count.index].name
#  value      = module.ec2_vm_euw2_c99_devops.mgmt_host_data[count.index].private_ip
#  type       = "A"
#  proxied    = false
#  depends_on = [module.ec2_vm_euw2_c99_devops.mgmt_host_data]
#}
#
#/* Alias */
#
#
#resource "cloudflare_record" "mgmt_c99_devops_euw2_admins_CNAME_records" {
#  zone_id    = local.current_cf_zone_id
#  count      = length(cloudflare_record.mgmt_c99_devops_euw2_admins_A_records)
#  name       = "mgmt-${format("%02d", count.index + 300)}"
#  value      = cloudflare_record.mgmt_c99_devops_euw2_admins_A_records[count.index].hostname
#  type       = "CNAME"
#  proxied    = false
#  depends_on = [cloudflare_record.mgmt_c99_devops_euw2_admins_A_records]
#}