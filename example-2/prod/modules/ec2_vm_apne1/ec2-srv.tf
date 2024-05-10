
resource "aws_instance" "srv_01_c1_prod_apne1" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3.xlarge"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ssh_pub"
  vpc_security_group_ids = [
    aws_security_group.c1_prod_apne1_sg_base_dynamic.id,
    aws_security_group.c1_sg_srv.id,
  ]
  ipv6_address_count = 1

  lifecycle {
    ignore_changes  = [user_data, ami]
    prevent_destroy = true
  }
  metadata_options {
    instance_metadata_tags = "enabled"
  }
  root_block_device {
    volume_type = "gp3"
    volume_size = 256
  }
  user_data = file(var.user_data_path)

  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-srv-51"
    Teleport_cls = var.c1_prod_teleport_cls_name
    Createdby    = local.c1_author_devops
    Group        = "srv_01_c1_prod_apne1"
    Backup       = "true"
  }
}


resource "aws_instance" "srv_06_c1_prod_apne1" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3.medium"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ssh_pub"
  vpc_security_group_ids = [
    aws_security_group.c1_prod_apne1_sg_base_dynamic.id,
    aws_security_group.c1_sg_srv.id,
  ]
  ipv6_address_count = 1

  lifecycle {
    ignore_changes  = [user_data, ami]
    prevent_destroy = true
  }
  metadata_options {
    instance_metadata_tags = "enabled"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 256
  }
  user_data = file(var.user_data_path)

  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-srv-56"
    Teleport_cls = var.c1_prod_teleport_cls_name
    Createdby    = local.c1_author_devops
    Group        = "srv_06_c1_prod_apne1"
    Backup       = "true"
  }
}

resource "aws_instance" "srv_07_c1_prod_apne1" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "t3.medium"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ssh_pub"
  vpc_security_group_ids = [
    aws_security_group.c1_prod_apne1_sg_base_dynamic.id,
    aws_security_group.c1_sg_srv.id,
  ]
  ipv6_address_count = 1

  lifecycle {
    ignore_changes  = [user_data, ami]
    prevent_destroy = true
  }
  metadata_options {
    instance_metadata_tags = "enabled"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 64
  }
  user_data = file(var.user_data_path)

  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-srv-57"
    Teleport_cls = var.c1_prod_teleport_cls_name
    Createdby    = local.c1_author_devops
    Group        = "srv_07_c1_prod_apne1"
    Backup       = "true"
  }
}


