resource "aws_eip" "c1_eip_rsrv_501" {
  provider = aws.ap-northeast-1
  count    = 1
  domain   = "vpc"
  tags = {
    Name      = "${var.c1_stand}-apne1 EIP  for rsrv-501 - ${count.index + 1}"
    Createdby = local.c1_author_devops
  }
}

#resource "aws_eip_association" "c1_eip_rsrv_501_assoc" {
#  provider      = aws.ap-northeast-1
#  count         = length(module.ec2_vm_apne1_c1_prod.rsrv_501_host_data)
#  instance_id   = module.ec2_vm_apne1_c1_prod.rsrv_501_host_data[count.index].id
#  allocation_id = element(aws_eip.c1_eip_rsrv_501.*.id, count.index)
#}