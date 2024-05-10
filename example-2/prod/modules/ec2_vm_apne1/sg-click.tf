resource "aws_security_group" "c1_sg_clickhouse_v1" {
  description = "managed by terraform"
  name_prefix = "c1-apne1-clickhouse-v1-sg-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  dynamic "ingress" {
    for_each = local.port_clickhouse
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      ipv6_cidr_blocks = [
        "${local.c1_prod_euw1_VPC_cidr56}",
        "${local.c1_prod_euw2_VPC_cidr56}",
        "${local.c1_prod_ape1_VPC_cidr56}",
        "${local.c1_prod_apne1_VPC_cidr56}",
      ]
    }
  }
  ingress {
    description = "CD-152 prom metrics port"
    from_port   = 9363
    to_port     = 9363
    protocol    = "tcp"
    cidr_blocks = [
      "${local.c1_prom_cidr}",
    ]
    ipv6_cidr_blocks = [
      "${local.c1_infra_euc1_prom_15_cidr6}",
    ]
  }

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} clickhouse access"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}