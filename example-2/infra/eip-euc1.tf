#/* jump hosts */
#resource "aws_eip" "c1_eip_mgmt_euc1" {
#  count  = 1
#  domain = "vpc"
#  tags = {
#    Name      = "euc1-${var.c1_stand} EIP  for mgmt host - ${count.index + 1}"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#}

#resource "aws_eip_association" "c1_eip_mgmt_euc1_assoc" {
#  count         = length(module.ec2_vm_euc1_c1_infra.mgmt_host_data)
#  instance_id   = module.ec2_vm_euc1_c1_infra.mgmt_host_data[count.index].id
#  allocation_id = element(aws_eip.c1_eip_mgmt_euc1.*.id, count.index)
#  depends_on = [
#    module.ec2_vm_euc1_c1_infra.mgmt_host_data,
#  ]
#}