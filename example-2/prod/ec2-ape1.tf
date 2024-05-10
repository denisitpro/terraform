module "ec2_vm_ape1_c1_prod" {
  source            = "./modules/ec2_vm_ape1"
  public_subnet_ids = module.vpc_ap_east_1.public_subnet_ids
  #  private_subnet_ids       = module.vpc_ap_east_1.private_subnet_ids
  c1_region_code = "ape1"
  user_data_path = "${path.module}/user_data/user_data_general-v2.sh"
  vpc_id         = module.vpc_ap_east_1.ape1_c1_prod_vpc_id
  providers = {
    aws = aws.ap-east-1
  }
}