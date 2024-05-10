#module "route53_eu_west_2" {
#  source = "./modules/route53"
#  #  region                              = "eu-west-2"
#  vpc_id                           = module.vpc_eu_west_2.euw2_c1_prod_vpc_id
#  c1_company_code                  = var.c1_company_code
#  c1_stand                         = var.c1_stand
#  c1_region_code                   = "euw2"
#  c1_global_var_access_key         = var.C1_GLOBAL_VAR_ACCESS_KEY
#  c1_global_var_secret_key         = var.C1_GLOBAL_VAR_SECRET_KEY
#  exchange_private_link_dns_records = module.vpc_eu_west_2.exchange_private_link_endpoint
#  providers = {
#    aws = aws.eu-west-2
#  }
#}