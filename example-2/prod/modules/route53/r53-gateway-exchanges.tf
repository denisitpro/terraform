#resource "aws_route53_zone" "gateway_exchange_com" {
#  name = "gateway.exchange.com"
#  /*   use VPC - autmoation set private zone */
#  vpc {
#    vpc_id = var.vpc_id
#  }
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code} fake zone for private link exchange"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#}
#
#resource "aws_route53_record" "test_zone_A_records" {
#  zone_id = local.zone_id
#  name    = "42"
#  type    = "A"
#  ttl     = 300
#  records = ["${local.exchange_dns_record_1}"]
#}