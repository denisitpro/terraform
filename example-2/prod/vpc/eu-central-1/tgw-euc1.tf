resource "aws_ec2_transit_gateway" "c1_prod_euc1_tgw" {
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
resource "aws_ec2_transit_gateway_vpc_attachment" "c1_prod_euc1_vpc_attach" {
  #  count              = 1
  #  subnet_ids         = [aws_subnet.c1_prod_euc1_public_subnets[count.index].id]
  subnet_ids         = [for s in aws_subnet.c1_prod_euc1_public_subnets : s.id]
  transit_gateway_id = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  vpc_id             = aws_vpc.c1_prod_euc1.id

  dns_support                                     = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} VPC attach"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}

/* attachment c1-infra-euc1 */
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "c1_prod_euc1_attach_accepter_c1_infra_euc1" {
  transit_gateway_attachment_id = var.c1_infra_euc1_to_c1_prod_euc1_attach_accepter

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} accepter c1-infra-euc1"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}

/* create route table */
resource "aws_ec2_transit_gateway_route_table" "c1_prod_euc1_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} route table"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}

/*  Create the Peering attachment in the creator side... Europa */
resource "aws_ec2_transit_gateway_peering_attachment" "c1_prod_euc1_peering_c1_prod_euw1" {
  transit_gateway_id      = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  peer_transit_gateway_id = var.c1_prod_euw1_tgw_id
  peer_account_id         = var.c1_prod_aws_account_id
  peer_region             = "eu-west-1"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} peering to c1-prod-euw1"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


resource "aws_ec2_transit_gateway_peering_attachment" "c1_prod_euc1_peering_c1_prod_euw2" {
  transit_gateway_id      = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  peer_transit_gateway_id = var.c1_prod_euw2_tgw_id
  peer_account_id         = var.c1_prod_aws_account_id
  peer_region             = "eu-west-2"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} peering to c1-prod-euw2"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


/*  Create the Peering attachment in the creator side... Asia */
resource "aws_ec2_transit_gateway_peering_attachment" "c1_prod_euc1_peering_c1_prod_ape1" {
  transit_gateway_id      = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  peer_transit_gateway_id = var.c1_prod_ape1_tgw_id
  peer_account_id         = var.c1_prod_aws_account_id
  peer_region             = "ap-east-1"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} peering to c1-prod-ape1"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


resource "aws_ec2_transit_gateway_peering_attachment" "c1_prod_euc1_peering_c1_prod_apne1" {
  transit_gateway_id      = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  peer_transit_gateway_id = var.c1_prod_apne1_tgw_id
  peer_account_id         = var.c1_prod_aws_account_id
  peer_region             = "ap-northeast-1"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} peering to c1-prod-apne1"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}


/* route section */
resource "aws_ec2_transit_gateway_route" "c1_prod_euc1_to_c1_infra_gen2_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  destination_cidr_block         = "10.99.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.c1_prod_euc1_attach_accepter_c1_infra_euc1.id
}

resource "aws_ec2_transit_gateway_route" "c1_prod_euc1_to_c1_infra_wg_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  destination_cidr_block         = "10.201.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.c1_prod_euc1_attach_accepter_c1_infra_euc1.id
}

resource "aws_ec2_transit_gateway_route" "c1_prod_euc1_to_c1_prod_apne1_route" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  destination_cidr_block         = "10.99.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_prod_euc1_peering_c1_prod_apne1.id
  #  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.c1_prod_euc1_peering_c1_prod_euw2.id
}


/* VPC attach */
resource "aws_ec2_transit_gateway_route" "c1_prod_euc1_to_vpc_euc1" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  destination_cidr_block         = "10.101.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c1_prod_euc1_vpc_attach.id
}


/*  accociation section */
resource "aws_ec2_transit_gateway_route_table_association" "c1_prod_euc1_to_c1_infra_euc1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.c1_prod_euc1_attach_accepter_c1_infra_euc1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "c1_prod_euc1_to_c1_prod_euw1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_prod_euc1_peering_c1_prod_euw1.id
}


resource "aws_ec2_transit_gateway_route_table_association" "c1_prod_euc1_to_c1_prod_euw2_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_prod_euc1_peering_c1_prod_euw2.id
}

/* assian asscoiation */
resource "aws_ec2_transit_gateway_route_table_association" "c1_prod_euc1_to_c1_prod_ape1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_prod_euc1_peering_c1_prod_ape1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "c1_prod_euc1_to_c1_prod_apne1_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.c1_prod_euc1_peering_c1_prod_apne1.id
}

/* vpc association */
resource "aws_ec2_transit_gateway_route_table_association" "c1_prod_to_c1_prod_vpc_assoc" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.c1_prod_euc1_rt.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.c1_prod_euc1_vpc_attach.id
}



output "tgw_id" {
  value = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
}
