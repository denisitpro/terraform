/* stand dependent output */
output "mgmt_host_data" {
  value = [for instance in aws_instance.mgmt_c1_infra_euc1_admins : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}

output "grafana_15_host_data" {
  value = [for instance in aws_instance.grafana_c1_infra_euc1 : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}

output "nginx_15_host_data" {
  value = [for instance in aws_instance.nginx_15_general_c1_infra_euc1 : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}
