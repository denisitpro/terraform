resource "aws_security_group" "c1_sg_msrv_v1" {
  name_prefix = "msrv-sg-c1-prod-euc1-"
  description = "managed by terraform"

  vpc_id = var.vpc_id

  ingress {
    description = "runner access to deploy"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "${local.c1_runner_15_deploy_cidr4}",
    ]
    ipv6_cidr_blocks = ["${local.c1_runner_15_deploy_cidr6}"]
  }


  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} msrv servers access"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}