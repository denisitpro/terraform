resource "aws_security_group" "c99_sg_mgmt_host_allow" {
  name        = "c99_sg_mgmt_host_allow"
  description = "c1 allow mgmt host connect"

  vpc_id = var.vpc_id

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
    Name      = "${var.c99_stand}-${var.c99_region_code} mgmt access"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}