module "ec2_vm_euc1_c1_infra" {
  source            = "./modules/ec2_vm_euc1"
  public_subnet_ids = module.vpc_eu_central_1.public_subnet_ids
  #  private_subnet_ids = module.vpc_eu_central_1.private_subnet_ids
  c1_region_code = "euc1"
  user_data_path = "${path.module}/user_data/user_data_general-v2.sh"
  vpc_id         = module.vpc_eu_central_1.euc1_c1_infra_vpc_id
  providers = {
    #    aws = aws.eu-central-1
    aws = aws
  }
}
