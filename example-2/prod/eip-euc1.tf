resource "aws_eip" "c1_eip_harvester-40" {
  #  provider = aws.eu-central-1
  count  = 1
  domain = "vpc"
  tags = {
    Name      = "${var.c1_stand}-euw1 EIP  for harvester-40 - ${count.index + 1}"
    Createdby = local.c1_author_devops
  }
}

resource "aws_eip_association" "c1_eip_harvester_40_assoc" {
  #  provider = aws.eu-central-1
  count         = length(module.ec2_vm_euc1_c1_prod.harvester_40_host_data)
  instance_id   = module.ec2_vm_euc1_c1_prod.harvester_40_host_data[count.index].id
  allocation_id = element(aws_eip.c1_eip_harvester-40.*.id, count.index)
}
