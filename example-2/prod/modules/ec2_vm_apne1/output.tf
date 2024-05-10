/* stand dependent output */
output "mgmt_host_data" {
  value = [for instance in aws_instance.mgmt_c1_prod_apne1_admins : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}

output "srv_01_host_data" {
  value = [for instance in aws_instance.srv_01_c1_prod_apne1 : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}

output "srv_06_host_data" {
  value = [for instance in aws_instance.srv_06_c1_prod_apne1 : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}

output "srv_07_host_data" {
  value = [for instance in aws_instance.srv_07_c1_prod_apne1 : {
    id             = instance.id
    name           = instance.tags["Name"]
    private_ip     = instance.private_ip
    public_ips     = instance.public_ip
    ipv6_addresses = instance.ipv6_addresses
  }]
}
