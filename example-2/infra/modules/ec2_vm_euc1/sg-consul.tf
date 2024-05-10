resource "aws_security_group" "c1_sg_consul_cls_v1" {
  description = "managed by terraform"
  name_prefix = "c1-euc1-consul-cls-v1-sg-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port = 8500
    to_port   = 8500
    protocol  = "tcp"
    cidr_blocks = [
      "${local.c1_infra_euc1_mgmt_cidr}",
    ]
    ipv6_cidr_blocks = [
      "${local.c1_infra_euc1_mgmt_cidr6}",
    ]
  }

  tags = {
    Name      = "${var.c1_region_code}-${var.c1_stand} consul cluster access"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}