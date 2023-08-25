resource "aws_vpc_dhcp_options" "c99_devops_dhcp_options" {
  domain_name         = "example.com"
  domain_name_servers = ["1.1.1.1", "8.8.8.8"]
  tags = {
    Name      = "${var.c99_stand}-${var.c99_region_code} dhcp options"
    Code      = local.c99_company_code
    Createdby = local.c99_author_denisitpro
  }
}

resource "aws_vpc_dhcp_options_association" "c99_devops_dhcp_options_association" {
  vpc_id          = aws_vpc.c99_devops_euc1.id
  dhcp_options_id = aws_vpc_dhcp_options.c99_devops_dhcp_options.id
}
