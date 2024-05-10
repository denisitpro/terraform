#resource "aws_route53_record" "gateway_exchange_alias" {
#  zone_id = local.zone_id
#  name    = "gateway.exchange.com"
#  type    = "A"
#  ttl     = 300
#  #  records    = ["vpce-123123-kw7v14q5.vpce-svc-040cd502947f69842.eu-west-2.vpce.amazonaws.com"]
#  records = ["1.1.1.1"]
#
#}

#resource "aws_route53_record" "gateway_exchange_alias" {
#  zone_id = local.zone_id
#  name    = "44.gateway.exchange.com"
#  type    = "A"
#  alias {
#    name                   = "vpce-123123-kw7v14q5.vpce-svc-040cd502947f69842.eu-west-2.vpce.amazonaws.com"
#    zone_id                = "Z7K87123"
#    evaluate_target_health = true
#  }
#}