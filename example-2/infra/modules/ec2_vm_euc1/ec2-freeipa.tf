resource "aws_instance" "freeipa_g2_c1_infra_euc1" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3a.large"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ssh_pub"

  vpc_security_group_ids = [
    aws_security_group.c1_sg_base_dynamic_v1.id,
    aws_security_group.c1_sg_freeipa_v1.id,
  ]
  private_ip = var.freeipa_g2_ip

  lifecycle {
    ignore_changes  = [user_data, ami]
    prevent_destroy = true
  }

  metadata_options {
    instance_metadata_tags = "enabled"
  }

  root_block_device {
    volume_size = 40
  }

  user_data = file("./user_data/user_data_general-v2.sh")

  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-ipa-16"
    Teleport_cls = local.c1_teleport_cls_name
    Createdby    = local.c1_author_devops
    Owner        = local.c1_tag_owner_devops
    Group        = "freeipa_g2_c1_infra_euc1"
    Backup       = "true"
    Task         = "CD-422"
  }
}