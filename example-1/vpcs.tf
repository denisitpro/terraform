/* left alias target, right name provider root level */

module "vpc_eu_central_1" {
  source                    = "./vpc/eu-central-1"
  region                    = "eu-central-1"
  c99_company_code          = local.c99_company_code
  c99_stand                 = var.c99_stand
  c99_region_code           = "euc1"
  c99_global_var_access_key = var.c99_GLOBAL_VAR_ACCESS_KEY
  c99_global_var_secret_key = var.c99_GLOBAL_VAR_SECRET_KEY
  providers = {
    #        aws.eu-central-1 = aws
    aws = aws
  }
}
#
#module "vpc_eu_west_2" {
#  source                                = "./vpc/eu-west-2"
#  region                                = "eu-west-2"
#  c99_company_code                       = local.c99_company_code
#  c99_stand                              = var.c99_stand
#  c99_region_code                        = "euw2"
#  c99_devops_aws_backup_service_role_arn = aws_iam_role.c99_devops_aws_backup_service_role.arn
#  c99_global_var_access_key              = var.c99_GLOBAL_VAR_ACCESS_KEY
#  c99_global_var_secret_key              = var.c99_GLOBAL_VAR_SECRET_KEY
#  providers = {
#    #        aws.eu-central-1 = aws
#    aws = aws.eu-west-2
#  }
#}