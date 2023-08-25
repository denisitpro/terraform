#####
# jump hosts
#resource "aws_eip" "c99_eip_mgmt" {
#  count  = 1
#  domain = "vpc"
#  tags = {
#    Name      = "${var.c99_region_code}-${var.c99_stand} EIP  for mgmt host - ${count.index + 1}"
#    Createdby    = local.c99_author_denisitpro
#    Owner        = local.c99_tag_owner_devops
#  }
#}
#
#resource "aws_eip_association" "c99_eip_mgmt_association" {
#  count         = 1
#  instance_id   = element(aws_instance.mgmt_c99_devops_euc99_admins.*.id, count.index)
#  allocation_id = element(aws_eip.c99_eip_mgmt.*.id, count.index)
#}