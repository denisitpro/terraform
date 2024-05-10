resource "aws_vpn_gateway" "c1_vpn_gw_provider" {
  vpc_id = aws_vpc.c1_prod_apne1.id
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} vpn gw for provider"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
    Task      = "DO-1731"
  }
}

/* enable route propagation
 Enable route propagation (Route Tables -> Route Propagation -> Enable route propagation for created Virtual Private Gateway) */
#resource "aws_vpn_gateway_route_propagation" "c1_vpn_route_propagation_provider" {
#  route_table_id = aws_route_table.c1_prod_apne1_second_rt.id
#  vpn_gateway_id = aws_vpn_gateway.c1_vpn_gw_provider.id
#}
