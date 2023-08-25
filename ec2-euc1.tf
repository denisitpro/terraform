module "ec2_vm_euc99_c99_devops" {
  source                    = "./modules/ec2_vm_euc1"
  public_subnet_ids         = module.vpc_eu_central_1.public_subnet_ids
  private_subnet_ids        = module.vpc_eu_central_1.private_subnet_ids
  c99_region_code           = "euc1"
  user_data_path            = "${path.module}/user_data/user_data_general-v2.sh"
  vpc_id                    = module.vpc_eu_central_1.euc99_c99_devops_vpc_id
  c99_global_var_access_key = var.c99_GLOBAL_VAR_ACCESS_KEY
  c99_global_var_secret_key = var.c99_GLOBAL_VAR_SECRET_KEY
  providers = {
    aws = aws
  }
}


module "ec2_vm_euw2_c99_devops" {
  source                    = "./modules/ec2_vm_euw2"
  public_subnet_ids         = module.vpc_eu_west_2.public_subnet_ids
  private_subnet_ids        = module.vpc_eu_west_2.private_subnet_ids
  c99_region_code           = "euw2"
  user_data_path            = "${path.module}/user_data/user_data_general-v2.sh"
  vpc_id                    = module.vpc_eu_west_2.euw2_c99_devops_vpc_id
  c99_global_var_access_key = var.c99_GLOBAL_VAR_ACCESS_KEY
  c99_global_var_secret_key = var.c99_GLOBAL_VAR_SECRET_KEY
  providers = {
    aws = aws.eu-west-2
  }
}
