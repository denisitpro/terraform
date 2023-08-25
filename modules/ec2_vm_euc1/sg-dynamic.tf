
resource "aws_security_group" "c99_devops_euc99_sg_base_dynamic" {
  name_prefix = "c99-devops-euc1-base-sg-"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
  /* mgmt host access to host */
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.c99_stand_mgmt_cidr}", "${local.c99_infra_euc99_mgmt_cidr}", "172.31.0.0/16"]
    #    cidr_blocks = ["0.0.0.0/0"]

  }


  /* egress traffic all*/
  dynamic "egress" {
    for_each = local.port_egress_tcp_all
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  dynamic "egress" {
    for_each = local.port_egress_udp_all
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
    from_port   = 10050 #ldaps
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = ["${local.c99_zbx_cidr}", "172.31.0.0/16"]
  }
  egress {
    from_port   = 10051 #ldaps
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = ["${local.c99_zbx_cidr}", "172.31.0.0/16"]
  }


  /* consul server discovery port */
  dynamic "ingress" {
    for_each = local.ports_consul
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8", "172.31.0.0/16"]
    }
  }
  dynamic "ingress" {
    for_each = local.ports_consul
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["10.0.0.0/8", "172.31.0.0/16"]
    }
  }
  egress {
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8", "172.31.0.0/16"]
  }
  dynamic "egress" {
    for_each = local.ports_consul
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8", "172.31.0.0/16"]
    }
  }
  dynamic "egress" {
    for_each = local.ports_consul
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "udp"
      cidr_blocks = ["10.0.0.0/8", "172.31.0.0/16"]
    }
  }

  /* prometheus discovery */
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${local.c99_prom_cidr}"]
  }
  /* allow traceroute work */
  ingress {
    description = "UDP for traceroute"
    from_port   = 33434
    to_port     = 33534
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "UDP for traceroute"
    from_port   = 33434
    to_port     = 33534
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /* allow freeipa ports  */
  dynamic "egress" {
    for_each = local.port_egress_ipa_both
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }
  dynamic "egress" {
    for_each = local.port_egress_ipa_both
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "udp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }

  tags = {
    Name      = "${var.c99_region_code}-${var.c99_stand} sg dynamic base access"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}