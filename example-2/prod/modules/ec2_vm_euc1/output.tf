output "mgmt_host_data" {
  value = [for instance in aws_instance.mgmt_c1_prod_euc1_admins : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}


output "msrv_400_host_data" {
  value = [for instance in aws_instance.msrv_400_c1_prod_euc1 : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}
