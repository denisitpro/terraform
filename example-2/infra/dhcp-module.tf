module "dhcp_eu_central_1" {
  source               = "git@github.com:example-com/tf-dhcp-module.git//dhcp?ref=1.0"
  stand                = var.c1_stand
  region_code          = "euc1"
  aws_dhcp_domain_name = "example.com"
  providers = {
    aws = aws
  }
}

resource "aws_vpc_dhcp_options_association" "c1_devops_euc1_dhcp_options_assoc" {
  vpc_id          = module.vpc_eu_central_1.euc1_c1_infra_vpc_id
  dhcp_options_id = module.dhcp_eu_central_1.current_dhcp_id
}