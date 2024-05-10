## create VPC object
resource "aws_vpc" "c1_prod_euc1" {
  cidr_block                       = var.c1_prod_euc1_vpc_cidr
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} vpc"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}

/* create public subnet use array variable cidrs */
resource "aws_subnet" "c1_prod_euc1_public_subnets" {
  count                           = length(var.c1_prod_euc1_public_subnet_cidrs)
  vpc_id                          = aws_vpc.c1_prod_euc1.id
  cidr_block                      = element(var.c1_prod_euc1_public_subnet_cidrs, count.index)
  availability_zone               = element(var.c1_prod_euc1_azs, count.index)
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.c1_prod_euc1.ipv6_cidr_block, 8, count.index)
  assign_ipv6_address_on_creation = true
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} - public subnet ${count.index + 1}"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}


/* Configure internet gateway */
resource "aws_internet_gateway" "c1_prod_euc1_gw" {
  vpc_id = aws_vpc.c1_prod_euc1.id
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} internet gateway"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}

/* create second route table */
resource "aws_route_table" "c1_prod_euc1_second_rt" {
  vpc_id = aws_vpc.c1_prod_euc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.c1_prod_euc1_gw.id
  }
  ## support route ipv6
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.c1_prod_euc1_gw.id
  }

  /* Add the following route to route traffic to Account 1's VPC via the Transit Gateway */
  route {
    cidr_block         = "10.99.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  }
  route {
    cidr_block         = "10.201.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
  }

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code}  - 2nd route table"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}

/* set name default route table */
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.c1_prod_euc1.default_route_table_id
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} default route table"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}

/*  associate public route table to subnet public */
resource "aws_route_table_association" "c1_prod_euc1_public_subnet_asso" {
  count          = length(var.c1_prod_euc1_public_subnet_cidrs)
  subnet_id      = element(aws_subnet.c1_prod_euc1_public_subnets[*].id, count.index)
  route_table_id = aws_route_table.c1_prod_euc1_second_rt.id
}

