## create VPC object
resource "aws_vpc" "c99_devops_euc1" {
  cidr_block                       = var.c99_devops_euc99_vpc_cidr
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} vpc"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* create public subnet use array variable cidrs */
resource "aws_subnet" "c99_devops_euc99_public_subnets" {
  count                           = length(var.c99_devops_euc99_public_subnet_cidrs)
  vpc_id                          = aws_vpc.c99_devops_euc1.id
  cidr_block                      = element(var.c99_devops_euc99_public_subnet_cidrs, count.index)
  availability_zone               = element(var.c99_devops_euc99_azs, count.index)
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.c99_devops_euc1.ipv6_cidr_block, 8, count.index)
  assign_ipv6_address_on_creation = true
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} - public subnet ${count.index + 1}"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* create private subnet use array variable */
resource "aws_subnet" "c99_private_euc99_subnets" {
  count             = length(var.c99_devops_euc99_private_subnet_cidrs)
  vpc_id            = aws_vpc.c99_devops_euc1.id
  cidr_block        = element(var.c99_devops_euc99_private_subnet_cidrs, count.index)
  availability_zone = element(var.c99_devops_euc99_azs, count.index)

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} - private subnet ${count.index + 1}"
    Createdby = local.c99_author_denisitpro
  }
}

/* Configure internet gateway */
resource "aws_internet_gateway" "c99_devops_euc99_gw" {
  vpc_id = aws_vpc.c99_devops_euc1.id
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} internet gateway"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* create second route table */
resource "aws_route_table" "c99_devops_euc99_second_rt" {
  vpc_id = aws_vpc.c99_devops_euc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.c99_devops_euc99_gw.id
  }
  ## support route ipv6
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.c99_devops_euc99_gw.id
  }
  # Add the following route to route traffic to Account 1's VPC via the Transit Gateway
  route {
    cidr_block         = "10.15.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  }
  route {
    cidr_block         = "10.19.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  }

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code}  - 2nd route table"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* set name default route table */
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.c99_devops_euc1.default_route_table_id
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} default route table"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/*  associate public route table to subnet public */
resource "aws_route_table_association" "c99_devops_euc99_public_subnet_asso" {
  count          = length(var.c99_devops_euc99_public_subnet_cidrs)
  subnet_id      = element(aws_subnet.c99_devops_euc99_public_subnets[*].id, count.index)
  route_table_id = aws_route_table.c99_devops_euc99_second_rt.id
}

/* create Elastic IP for GW - need multi AZ */
resource "aws_eip" "c99_devops_euc99_eip_igw" {
  count      = length(var.c99_devops_euc99_public_subnet_cidrs)
  domain     = "vpc"
  depends_on = [aws_internet_gateway.c99_devops_euc99_gw]
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code}  EIP for AZ ${count.index + 1}"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* create NAT gateway - need multi AZ */
resource "aws_nat_gateway" "c99_devops_euc99_nat_gw" {
  count         = length(var.c99_devops_euc99_public_subnet_cidrs)
  allocation_id = aws_eip.c99_devops_euc99_eip_igw[count.index].allocation_id
  subnet_id     = aws_subnet.c99_devops_euc99_public_subnets[count.index].id
  depends_on = [
    aws_internet_gateway.c99_devops_euc99_gw,
  ]

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} nat gateway ${count.index + 1}"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* create route table with target as NAT gateway */
resource "aws_route_table" "c99_devops_euc99_nat_route_table" {
  count  = length(var.c99_devops_euc99_private_subnet_cidrs)
  vpc_id = aws_vpc.c99_devops_euc1.id

  dynamic "route" {
    for_each = aws_nat_gateway.c99_devops_euc99_nat_gw
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.c99_devops_euc99_nat_gw[count.index].id
    }
  }
  /* Add the following route to route traffic to Account 1's VPC via the Transit Gateway */
  route {
    cidr_block         = "10.15.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  }
  route {
    cidr_block         = "10.19.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.c99_devops_euc99_tgw.id
  }

  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} nat route table  ${count.index + 1}"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}

/* associate route table to private subnet */
resource "aws_route_table_association" "associate_routetable_to_private_subnet" {
  count = length(var.c99_devops_euc99_public_subnet_cidrs)
  depends_on = [
    aws_subnet.c99_private_euc99_subnets,
    aws_route_table.c99_devops_euc99_nat_route_table,
  ]
  subnet_id      = aws_subnet.c99_private_euc99_subnets[count.index].id
  route_table_id = aws_route_table.c99_devops_euc99_nat_route_table[count.index].id
}