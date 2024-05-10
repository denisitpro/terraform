resource "aws_instance" "gitlab_devel_g2_c1_infra_euc1" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3.large"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ssh_pub"
  vpc_security_group_ids = [
    aws_security_group.c1_sg_base_dynamic_v1.id,
    aws_security_group.c1_sg_gitlab_devel_v1.id,
  ]
  private_ip = var.c1_infra_euc1_gitlab_devel_g2_ip

  lifecycle {
    ignore_changes  = [user_data, ami]
    prevent_destroy = true
  }

  metadata_options {
    instance_metadata_tags = "enabled"
  }

  root_block_device {
    volume_size = 128
    volume_type = "gp2"
  }

  user_data = file("./user_data/user_data_general-v2.sh")

  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-gitlab-16"
    Teleport_cls = local.c1_teleport_cls_name
    Createdby    = local.c1_author_ravil_snagatullin
    Owner        = local.c1_tag_owner_devops
    Group        = "gitlab_devel_g2_c1_infra_euc1"
    Task         = "CD-236"
    Backup       = "true"
  }
}