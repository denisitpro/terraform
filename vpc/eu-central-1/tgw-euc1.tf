resource "aws_ec2_transit_gateway" "c99_devops_euc99_tgw" {
  description                     = "${var.c99_stand}-${var.c99_region_code} transit gateway for VPC connectivity"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} TGW"
    Code      = local.c99_company_code
    Createdby = local.c99_author_denisitpro
  }
}
#
##
/* attachment internal VPC */
resource "aws_ec2_transit_gateway_vpc_attachment" "c99_devops_euc99_vpc_attach" {
  #  count          = length(var.c99_devops_private_subnet_cidrs)
  count              = 1
  subnet_ids         = [aws_subnet.c99_private_euc99_subnets[count.index].id]
  transit_gateway_id = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  vpc_id             = aws_vpc.c99_devops_euc1.id

  dns_support                                     = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} VPC attach ${count.index + 1}"
    Code      = local.c99_company_code
    Createdby = local.c99_author_denisitpro
  }
}

/* attachment c99-infra-euc1 */
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "c99_devops_euc99_attach_accepter_c99_infra_euc1" {
  transit_gateway_attachment_id = var.c99_infra_euc99_g2_to_c99_devops_euc99_attach_accepter

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} accepter c99-infra-euc1-g2-v2"
    Code      = local.c99_company_code
    Createdby = local.c99_author_denisitpro
  }
}

/*  Create the Peering attachment in the creator side... */
resource "aws_ec2_transit_gateway_peering_attachment" "c99_devops_euc99_peering_c99_devops_euw2" {
  transit_gateway_id      = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  peer_transit_gateway_id = var.c99_devops_euw2_tgw_id
  peer_account_id         = local.c99_devops_aws_account_id
  peer_region             = "eu-west-2"
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} peering to c99-devops-euw2"
    Code      = local.c99_company_code
    Createdby = local.c99_author_denisitpro
  }
}

/* create route table */
resource "aws_ec2_transit_gateway_route_table" "c99_devops_euc99_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} route table"
    Code      = local.c99_company_code
    Createdby = local.c99_author_denisitpro
  }
}


/* create route tables */

resource "aws_ec2_transit_gateway_route" "c99_devops_euc99_to_c99_infra_gen2_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c99_devops_euc99_rt.id
  destination_cidr_block         = "10.15.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.c99_devops_euc99_attach_accepter_c99_infra_euc1.id
}

resource "aws_ec2_transit_gateway_route" "c99_devops_euc99_to_c99_infra_wg_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c99_devops_euc99_rt.id
  destination_cidr_block         = "10.19.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.c99_devops_euc99_attach_accepter_c99_infra_euc1.id
}


/* route to VPC */
resource "aws_ec2_transit_gateway_route" "c99_devops_euc99_to_vpc_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c99_devops_euc99_rt.id
  destination_cidr_block         = "10.225.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c99_devops_euc99_vpc_attach[0].id
}


/*  accociation section */
resource "aws_ec2_transit_gateway_route_table_association" "c99_devops_euc99_to_c99_infra_euc99_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c99_devops_euc99_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.c99_devops_euc99_attach_accepter_c99_infra_euc1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "c99_devops_euc99_to_c99_devops_euw2_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c99_devops_euc99_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c99_devops_euc99_peering_c99_devops_euw2.id
}

resource "aws_ec2_transit_gateway_route_table_association" "c99_devops_to_c99_devops_vpc_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c99_devops_euc99_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c99_devops_euc99_vpc_attach[0].id
}



output "tgw_id" {
  value = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
}
