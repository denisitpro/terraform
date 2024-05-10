#output "mgmt_host_data" {
#  value = [for instance in aws_instance.mgmt_c99_devops_euw2_admins : {
#    id = instance.id
#    name = instance.tags["Name"]
#    private_ip = instance.private_ip
#    public_ips = instance.public_ip
#    ipv6_addresses = instance.ipv6_addresses
#  }]
#}
