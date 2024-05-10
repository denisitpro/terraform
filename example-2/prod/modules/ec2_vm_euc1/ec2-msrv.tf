resource "aws_instance" "msrv_400_c1_prod_euc1" {
  count         = 1
  ami           = local.current_region_ami_id
  instance_type = "m6a.8xlarge"
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = "c1_devops_ed25519_pub"
  vpc_security_group_ids = [
    aws_security_group.c1_prod_euc1_sg_base_dynamic.id,
    aws_security_group.c1_sg_msrv_v1.id
  ]
  ipv6_address_count = 1

  lifecycle {
    ignore_changes  = [user_data, ami]
    prevent_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 750
  }

  metadata_options {
    instance_metadata_tags = "enabled"
  }
  /* need for cloudwatch */
  monitoring           = true /* for support every 1 min mon https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch-new.html */
  iam_instance_profile = aws_iam_instance_profile.c1_cloudwatch_agent_profile.name


  user_data = file("./user_data/user_data_general-v2.sh")


  tags = {
    Name         = "${var.c1_region_code}-${var.c1_stand}-msrv-400"
    Teleport_cls = local.c1_teleport_cls_name
    Createdby    = local.c1_author_devops
    Group        = "msrv_400_c1_prod_euc1"
    Backup       = "true"
    Task         = "DO-2223"
  }
}