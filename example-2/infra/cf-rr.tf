resource "cloudflare_record" "consul_euc1_aws_rr_aws_A" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.consul_g2_c1_infra_euc1_ipv4)
  name       = "consul-c1-aws"
  type       = "A"
  ttl        = 300
  value      = module.ec2_vm_euc1_c1_infra.consul_g2_host_data[count.index].private_ip
  depends_on = [module.ec2_vm_euc1_c1_infra.consul_g2_host_data]
}

resource "cloudflare_record" "consul_euc1_aws_rr_aws_AAAA" {
  zone_id    = local.current_cf_zone_id
  count      = length(cloudflare_record.consul_g2_c1_infra_euc1_ipv4)
  name       = "consul-c1-aws"
  type       = "AAAA"
  ttl        = 300
  value      = module.ec2_vm_euc1_c1_infra.consul_g2_host_data[count.index].ipv6_addresses[0]
  depends_on = [module.ec2_vm_euc1_c1_infra.consul_g2_host_data]
}