module "ec2_vm_apne1_c1_prod" {
  source            = "./modules/ec2_vm_apne1"
  public_subnet_ids = module.vpc_ap_northeast_1.public_subnet_ids
  #  private_subnet_ids       = module.vpc_ap_northeast_1.private_subnet_ids
  #  egw_pub_subnet_ids       = module.vpc_ap_northeast_1.egw_pub_subnet_ids
  #  egw_provider_subnet_ids  = module.vpc_ap_northeast_1.egw_provider_subnet_ids
  c1_region_code = "apne1"
  user_data_path = "${path.module}/user_data/user_data_general-v2.sh"
  vpc_id         = module.vpc_ap_northeast_1.apne1_c1_prod_vpc_id
  providers = {
    aws = aws.ap-northeast-1
  }
}