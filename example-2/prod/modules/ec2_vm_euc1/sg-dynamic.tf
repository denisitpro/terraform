
resource "aws_security_group" "c1_prod_euc1_sg_base_dynamic" {
  name_prefix = "c1-prod-euc1-base-sg-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
  ingress {
    description = "ssh access mgmt and vpn"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      #      "${var.c1_stand_mgmt_cidr}",
      "${local.c1_infra_euc1_mgmt_cidr}",
      "${local.c1_prod_euc1_mgmt_cidr}",
    ]
    ipv6_cidr_blocks = [
      "${local.c1_infra_euc1_mgmt_cidr6}",
      "${local.c1_infra_fsn1_mgmt_cidr6}",
    ]
  }




  /* egress traffic all*/
  dynamic "egress" {
    for_each = var.port_egress_tcp_all
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  dynamic "egress" {
    for_each = var.port_egress_udp_all
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  /* ICMP allow all port */
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmpv6"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmpv6"
    ipv6_cidr_blocks = ["::/0"]
  }
  #  /* zabbix server rules */
  ingress {
    from_port        = 10050
    to_port          = 10050
    protocol         = "tcp"
    ipv6_cidr_blocks = ["${local.c1_infra_euc1_zbx_15_cidr6}"]
  }

  egress {
    from_port        = 10051
    to_port          = 10051
    protocol         = "tcp"
    ipv6_cidr_blocks = ["${local.c1_infra_euc1_zbx_15_cidr6}"]
  }

  /* consul server discovery port */
  dynamic "ingress" {
    for_each = local.base_protocols
    content {
      description = "Consul communication ports"
      from_port   = 8300
      to_port     = 8302
      protocol    = ingress.value
      ipv6_cidr_blocks = [
        "${local.c1_infra_euc1_VPC_cidr56}",
        "${local.c1_prod_euc1_VPC_cidr56}",
        "${local.c1_prod_euw1_VPC_cidr56}",
        "${local.c1_prod_euw2_VPC_cidr56}",
        "${local.c1_prod_ape1_VPC_cidr56}",
        "${local.c1_prod_apne1_VPC_cidr56}",
      ]
    }
  }

  dynamic "egress" {
    for_each = local.base_protocols
    content {
      description      = "Consul communication ports"
      from_port        = 8300
      to_port          = 8302
      protocol         = egress.value
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  /* prometheus discovery */
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${local.c1_prom_cidr}"]
    ipv6_cidr_blocks = [
      "${local.c1_infra_euc1_prom_15_cidr6}",
    ]
  }
  /* allow traceroute work */
  ingress {
    description      = "UDP for traceroute"
    from_port        = 33434
    to_port          = 33534
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "UDP for traceroute"
    from_port        = 33434
    to_port          = 33534
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  /* allow freeipa ports  */
  dynamic "egress" {
    for_each = var.port_egress_ipa_both
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }
  dynamic "egress" {
    for_each = var.port_egress_ipa_both
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "udp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }

  tags = {
    Name      = "${var.c1_region_code}-${var.c1_stand} sg dynamic base access"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}