resource "aws_security_group" "c1_sg_freeipa_v1" {
  description = "managed by terraform"
  name_prefix = "c1-euc1-freeipa-v1-sg-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  dynamic "ingress" {
    for_each = local.ports_http
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }

  dynamic "ingress" {
    for_each = local.port_egress_ipa_both
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }


  dynamic "ingress" {
    for_each = local.port_egress_ipa_both
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }


  tags = {
    Name      = "${var.c1_region_code}-${var.c1_stand} freeipa access"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}