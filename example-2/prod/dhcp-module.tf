module "dhcp_eu_central_1" {
  source               = "git@github.com:example-com/tf-dhcp-module.git//dhcp?ref=1.0"
  stand                = var.c1_stand
  region_code          = "euc1"
  aws_dhcp_domain_name = "example-prod.com"
  providers = {
    aws = aws
  }
}

resource "aws_vpc_dhcp_options_association" "c1_devops_euc1_dhcp_options_assoc" {
  vpc_id          = module.vpc_eu_central_1.euc1_c1_prod_vpc_id
  dhcp_options_id = module.dhcp_eu_central_1.current_dhcp_id
}


module "dhcp_eu_west_1" {
  source               = "git@github.com:example-com/tf-dhcp-module.git//dhcp?ref=1.0"
  stand                = var.c1_stand
  region_code          = "euw1"
  aws_dhcp_domain_name = "example-prod.com"
  providers = {
    aws = aws.eu-west-1
  }
}

resource "aws_vpc_dhcp_options_association" "c1_devops_euw1_dhcp_options_assoc" {
  provider        = aws.eu-west-1
  vpc_id          = module.vpc_eu_west_1.euw1_c1_prod_vpc_id
  dhcp_options_id = module.dhcp_eu_west_1.current_dhcp_id
  depends_on      = [module.dhcp_eu_west_1]
}


module "dhcp_eu_west_2" {
  source               = "git@github.com:example-com/tf-dhcp-module.git//dhcp?ref=1.0"
  stand                = var.c1_stand
  region_code          = "euw2"
  aws_dhcp_domain_name = "example-prod.com"
  providers = {
    aws = aws.eu-west-2
  }
}

resource "aws_vpc_dhcp_options_association" "c1_devops_euw2_dhcp_options_assoc" {
  provider        = aws.eu-west-2
  vpc_id          = module.vpc_eu_west_2.euw2_c1_prod_vpc_id
  dhcp_options_id = module.dhcp_eu_west_2.current_dhcp_id
  depends_on      = [module.dhcp_eu_west_2]
}

module "dhcp_ap_east_1" {
  source               = "git@github.com:example-com/tf-dhcp-module.git//dhcp?ref=1.0"
  stand                = var.c1_stand
  region_code          = "ape1"
  aws_dhcp_domain_name = "example-prod.com"
  providers = {
    aws = aws.ap-east-1
  }
}

resource "aws_vpc_dhcp_options_association" "c1_devops_ape1_dhcp_options_assoc" {
  provider        = aws.ap-east-1
  vpc_id          = module.vpc_ap_east_1.ape1_c1_prod_vpc_id
  dhcp_options_id = module.dhcp_ap_east_1.current_dhcp_id
  depends_on      = [module.dhcp_ap_east_1]
}


module "dhcp_ap_northeast_1" {
  source               = "git@github.com:example-com/tf-dhcp-module.git//dhcp?ref=1.0"
  stand                = var.c1_stand
  region_code          = "apne1"
  aws_dhcp_domain_name = "example-prod.com"
  providers = {
    aws = aws.ap-northeast-1
  }
}

resource "aws_vpc_dhcp_options_association" "c1_devops_apne1_dhcp_options_assoc" {
  provider        = aws.ap-northeast-1
  vpc_id          = module.vpc_ap_northeast_1.apne1_c1_prod_vpc_id
  dhcp_options_id = module.dhcp_ap_northeast_1.current_dhcp_id
  depends_on      = [module.dhcp_ap_northeast_1]
}