resource "aws_instance" "mgmt_c1_prod_apne1_admins" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ssh_pub"
  vpc_security_group_ids = [
    aws_security_group.c1_sg_mgmt_host_allow.id,
    aws_security_group.c1_prod_apne1_sg_base_dynamic.id,
  ]
  ipv6_address_count = 1
  private_ip         = var.c1_prod_apne1_mgmt_ip

  lifecycle {
    ignore_changes = [user_data, ami]
  }
  metadata_options {
    instance_metadata_tags = "enabled"
  }

  user_data = file(var.user_data_path)

  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-mgmt-${format("%02d", count.index + 50)}"
    Teleport_cls = var.c1_prod_teleport_cls_name
    Createdby    = local.c1_author_devops
    Owner        = local.c1_tag_owner_devops
  }
}
