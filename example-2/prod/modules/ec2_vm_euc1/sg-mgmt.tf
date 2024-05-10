resource "aws_security_group" "c1_sg_mgmt_host_allow" {
  name_prefix = "c1_sg_mgmt_host-"

  description = "c1 allow mgmt host connect"

  vpc_id = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 8500
    to_port          = 8500
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "${var.c1_region_code}-${var.c1_stand} mgmt access"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}