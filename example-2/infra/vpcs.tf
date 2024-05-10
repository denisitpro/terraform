#/* left alias target, right name provider root level */
#
module "vpc_eu_central_1" {
  source                               = "./vpc/eu-central-1"
  region                               = "eu-central-1"
  c1_stand                             = var.c1_stand
  c1_region_code                       = "euc1"
  c1_infra_aws_backup_service_role_arn = aws_iam_role.c1_infra_aws_backup_service_role.arn
  c1_infra_IPSEC_PRESHARE_KEY          = var.c1_infra_IPSEC_PRESHARE_KEY
  wg_interface_id                      = module.ec2_vm_euc1_c1_infra.wg_interface_id
  providers = {
    #    aws = aws.eu-central-1
    aws = aws
  }
}

