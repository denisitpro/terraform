## Create a customer gateway resource representing your remote IPsec server
resource "aws_customer_gateway" "c1_infra_euc1_to_s2s_01_cgw" {
  bgp_asn    = 65000           # Replace with the BGP ASN of your remote IPsec server
  ip_address = "49.12.217.227" # Replace with the public IP address of your remote IPsec server
  type       = "ipsec.1"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code}  customer gw to c1-infra-fsn1"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}



### Create the VPN connection resource
resource "aws_vpn_connection" "c1_infra_euc1_to_c1_infra_fsn1_all_vpn_conn" {
  lifecycle {
    create_before_destroy = true
  }
  transit_gateway_id    = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
  customer_gateway_id   = aws_customer_gateway.c1_infra_euc1_to_s2s_01_cgw.id
  type                  = aws_customer_gateway.c1_infra_euc1_to_s2s_01_cgw.type
  static_routes_only    = true
  tunnel1_preshared_key = var.c1_infra_IPSEC_PRESHARE_KEY
  tunnel2_preshared_key = var.c1_infra_IPSEC_PRESHARE_KEY
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} VPN connect to c1-infra-fsn1"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
  depends_on = [aws_customer_gateway.c1_infra_euc1_to_s2s_01_cgw]
}

#resource "aws_vpn_connection" "c1_infra_euc1_to_c1_devel_fsn1" {
#  lifecycle {
#    create_before_destroy = true
#  }
#  transit_gateway_id    = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
#  customer_gateway_id   = aws_customer_gateway.c1_infra_euc1_to_s2s_130_c1_devel_fsn1_cgw.id
#  type                  = aws_customer_gateway.c1_infra_euc1_to_s2s_130_c1_devel_fsn1_cgw.type
#  static_routes_only    = true
#  tunnel1_preshared_key = var.c1_infra_IPSEC_PRESHARE_KEY
#  tunnel2_preshared_key = var.c1_infra_IPSEC_PRESHARE_KEY
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code} VPN connect to c1-devel-fsn1"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#  depends_on = [aws_customer_gateway.c1_infra_euc1_to_s2s_130_c1_devel_fsn1_cgw]
#}


#resource "aws_vpn_connection" "c1_infra_euc1_to_c1_aws_legacy_euc1_vpn_conn" {
#  lifecycle {
#    create_before_destroy = true
#  }
#  transit_gateway_id    = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
#  customer_gateway_id   = aws_customer_gateway.c1_infra_euc1_to_s2s_aws_legacy_cgw.id
#  type                  = aws_customer_gateway.c1_infra_euc1_to_s2s_aws_legacy_cgw.type
#  static_routes_only    = true
#  tunnel1_preshared_key = var.c1_infra_IPSEC_PRESHARE_KEY
#  tunnel2_preshared_key = var.c1_infra_IPSEC_PRESHARE_KEY
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code} VPN connect to c1-aws-legacy-euc1"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#  depends_on = [aws_customer_gateway.c1_infra_euc1_to_s2s_aws_legacy_cgw]
#}


/* output data */

#output "AWStunnels" {
#  value = {
#    htz_gen_tunnel1_ip = aws_vpn_connection.c1_infra_euc1_to_c1_infra_fsn1_all_vpn_conn.tunnel1_address
#    htz_gen_tunnel2_ip = aws_vpn_connection.c1_infra_euc1_to_c1_infra_fsn1_all_vpn_conn.tunnel2_address
#    fsn1_gen_tunnel1 = aws_vpn_connection.c1_infra_euc1_to_c1_devel_fsn1.tunnel1_address
#    fsn1_gen_tunnel2 = aws_vpn_connection.c1_infra_euc1_to_c1_devel_fsn1.tunnel2_address
#  }
#}

data "aws_ec2_transit_gateway_vpn_attachment" "c1_infra_euc1_to_c1_infra_fsn1_vpn_attach" {
  vpn_connection_id = aws_vpn_connection.c1_infra_euc1_to_c1_infra_fsn1_all_vpn_conn.id
}

#data "aws_ec2_transit_gateway_vpn_attachment" "c1_infra_euc1_to_c1_devel_fsn1_vpn_attach" {
#  vpn_connection_id = aws_vpn_connection.c1_infra_euc1_to_c1_devel_fsn1.id
#}

#data "aws_ec2_transit_gateway_vpn_attachment" "c1_infra_euc1_to_c1_aws_legacy_euc1_vpn_attach" {
#  vpn_connection_id = aws_vpn_connection.c1_infra_euc1_to_c1_aws_legacy_euc1_vpn_conn.id
#}

locals {
  vpn_connection_id                                = aws_vpn_connection.c1_infra_euc1_to_c1_infra_fsn1_all_vpn_conn.id
  c1_infra_euc1_to_c1_infra_fsn1_all_tgw_attach_id = data.aws_ec2_transit_gateway_vpn_attachment.c1_infra_euc1_to_c1_infra_fsn1_vpn_attach.id
  #  c1_infra_euc1_to_c1_devel_fsn1_tgw_attach_id     = data.aws_ec2_transit_gateway_vpn_attachment.c1_infra_euc1_to_c1_devel_fsn1_vpn_attach.id
  #  c1_infra_euc1_to_c1_aws_legacy_euc1_tgw_attach_id = data.aws_ec2_transit_gateway_vpn_attachment.c1_infra_euc1_to_c1_aws_legacy_euc1_vpn_attach.id
}