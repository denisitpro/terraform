resource "aws_instance" "mgmt_c99_devops_euc99_admins" {
  #  count          = length(var.public_subnet_ids) #count support az count
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c99_denisitpro_ssh_pub"
  vpc_security_group_ids = [
    aws_security_group.c99_sg_mgmt_host_allow.id,
    aws_security_group.c99_devops_euc99_sg_base_dynamic.id,
  ]
  ipv6_address_count = 1
  private_ip         = var.c99_stand_mgmt_ip

  lifecycle {
    ignore_changes = [user_data, ami]
  }
  metadata_options {
    instance_metadata_tags = "enabled"
  }

  user_data = file(var.user_data_path)

  tags = {
    Name         = "${var.c99_region_code}-${var.c99_stand}-mgmt-${format("%02d", count.index + 125)}"
    Teleport_cls = local.c99_teleport_cls_name
    Createdby    = local.c99_author_denisitpro
    Owner        = local.c99_tag_owner_devops
  }
}
