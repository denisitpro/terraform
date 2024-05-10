/* create private subnet use array variable */
#resource "aws_subnet" "c1_private_euc1_subnets" {
#  count             = length(var.c1_prod_euc1_private_subnet_cidrs)
#  vpc_id            = aws_vpc.c1_prod_euc1.id
#  cidr_block        = element(var.c1_prod_euc1_private_subnet_cidrs, count.index)
#  availability_zone = element(var.c1_prod_euc1_azs, count.index)
#
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code} - private subnet ${count.index + 1}"
#    Createdby = local.c1_author_devops
#  }
#}

/* create Elastic IP for GW - need multi AZ */
#resource "aws_eip" "c1_prod_euc1_eip_igw" {
#  count      = length(var.c1_prod_euc1_public_subnet_cidrs)
#  domain     = "vpc"
#  depends_on = [aws_internet_gateway.c1_prod_euc1_gw]
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code}  EIP for AZ ${count.index + 1}"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#}
#
#/* create NAT gateway - need multi AZ */
#resource "aws_nat_gateway" "c1_prod_euc1_nat_gw" {
#  count         = length(var.c1_prod_euc1_public_subnet_cidrs)
#  allocation_id = aws_eip.c1_prod_euc1_eip_igw[count.index].allocation_id
#  subnet_id     = aws_subnet.c1_prod_euc1_public_subnets[count.index].id
#  depends_on = [
#    aws_internet_gateway.c1_prod_euc1_gw,
#  ]
#
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code} nat gateway ${count.index + 1}"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#}
#
#/* create route table with target as NAT gateway */
#resource "aws_route_table" "c1_prod_euc1_nat_route_table" {
#  count  = length(var.c1_prod_euc1_private_subnet_cidrs)
#  vpc_id = aws_vpc.c1_prod_euc1.id
#
#  dynamic "route" {
#    for_each = aws_nat_gateway.c1_prod_euc1_nat_gw
#    content {
#      cidr_block     = "0.0.0.0/0"
#      nat_gateway_id = aws_nat_gateway.c1_prod_euc1_nat_gw[count.index].id
#    }
#  }
#  /* Add the following route to route traffic to Account 1's VPC via the Transit Gateway */
#  route {
#    cidr_block         = "10.99.0.0/16"
#    transit_gateway_id = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
#  }
#  route {
#    cidr_block         = "10.201.0.0/16"
#    transit_gateway_id = aws_ec2_transit_gateway.c1_prod_euc1_tgw.id
#  }
#
#  tags = {
#    Name      = "${var.c1_stand}-${var.c1_region_code} nat route table  ${count.index + 1}"
#    Createdby = local.c1_author_devops
#    Owner     = local.c1_tag_owner_devops
#  }
#}
#
#/* associate route table to private subnet */
#resource "aws_route_table_association" "associate_routetable_to_private_subnet" {
#  count = length(var.c1_prod_euc1_public_subnet_cidrs)
#  depends_on = [
#    aws_subnet.c1_private_euc1_subnets,
#    aws_route_table.c1_prod_euc1_nat_route_table,
#  ]
#  subnet_id      = aws_subnet.c1_private_euc1_subnets[count.index].id
#  route_table_id = aws_route_table.c1_prod_euc1_nat_route_table[count.index].id
#}