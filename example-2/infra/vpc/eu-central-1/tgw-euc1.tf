resource "aws_ec2_transit_gateway" "c1_infra_euc1_tgw" {
  description                     = "${var.c1_stand}-${var.c1_region_code} transit gateway for VPC connectivity"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} TGW"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


/* attachment internal VPC */
resource "aws_ec2_transit_gateway_vpc_attachment" "c1_infra_euc1_vpc_attach" {
  #  count              = 1
  #  subnet_ids         = [aws_subnet.c1_private_euc1_subnets[count.index].id]
  subnet_ids         = [for s in aws_subnet.c1_infra_euc1_public_subnets : s.id]
  transit_gateway_id = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
  vpc_id             = aws_vpc.c1_infra_euc1.id

  dns_support                                     = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} VPC attach"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}

/* route tables */
resource "aws_ec2_transit_gateway_route_table" "c1_infra_euc1_tgw_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} route table"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}

/*  Create the Peering attachment in the creator side... */
resource "aws_ec2_transit_gateway_peering_attachment" "c1_infra_euc1_peering_c1_devops_euc1" {
  transit_gateway_id      = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
  peer_transit_gateway_id = var.c1_devops_euc1_tgw_id
  peer_account_id         = local.c1_devops_aws_account_id
  peer_region             = "eu-central-1"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} peering to c1-devops-euc1"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


resource "aws_ec2_transit_gateway_peering_attachment" "c1_infra_euc1_peering_c1_prod_euc1" {
  transit_gateway_id      = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
  peer_transit_gateway_id = var.c1_prod_euc1_tgw_id
  peer_account_id         = local.c1_prod_aws_account_id
  peer_region             = "eu-central-1"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} peering to c1-prod-euc1"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


/* route section */


resource "aws_ec2_transit_gateway_route" "c1_infra_euc1_to_c1_prod_ape1_route" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  destination_cidr_block         = "10.100.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_infra_euc1_peering_c1_prod_euc1.id
}

resource "aws_ec2_transit_gateway_route" "c1_infra_euc1_to_c1_prod_apne1_route" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  destination_cidr_block         = "10.101.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_infra_euc1_peering_c1_prod_euc1.id
}


/* VPC route */
resource "aws_ec2_transit_gateway_route" "c1_infra_euc1_to_vpc_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  destination_cidr_block         = "10.99.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c1_infra_euc1_vpc_attach.id
}

resource "aws_ec2_transit_gateway_route" "c1_infra_euc1_to_vpc_wg_vpn_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  destination_cidr_block         = "10.59.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c1_infra_euc1_vpc_attach.id
}



/*  assoc section - peering */

resource "aws_ec2_transit_gateway_route_table_association" "c1_infra_euc1_to_c1_devops_euc1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_infra_euc1_peering_c1_devops_euc1.id
}

/* c1-devel gen2 */
resource "aws_ec2_transit_gateway_route_table_association" "c1_infra_euc1_to_c1_devops_g2_euc1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_infra_euc1_peering_c1_devel_gen2_euc1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "c1_infra_euc1_to_c1_prod_euc1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_infra_euc1_peering_c1_prod_euc1.id
}

#----------------------------------------------------------


/*  accociation section - VPN */
resource "aws_ec2_transit_gateway_route_table_association" "c1_infra_euc1_to_c1_infra_fsn1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  transit_gateway_attachment_id  = local.c1_infra_euc1_to_c1_infra_fsn1_all_tgw_attach_id
}
#
#resource "aws_ec2_transit_gateway_route_table_association" "c1_infra_euc1_to_c1_devel_fsn1_assoc" {
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
#  transit_gateway_attachment_id  = local.c1_infra_euc1_to_c1_devel_fsn1_tgw_attach_id
#}


#----------------------------------------------------------

/*  association section - VPC  */
resource "aws_ec2_transit_gateway_route_table_association" "c1_infra_to_c1_infra_vpc_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_infra_euc1_tgw_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c1_infra_euc1_vpc_attach.id
}


output "tgw_id" {
  value = aws_ec2_transit_gateway.c1_infra_euc1_tgw.id
}
