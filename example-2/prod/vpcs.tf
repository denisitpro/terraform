/* left alias target, right source name provider root level */

module "vpc_eu_central_1" {
  source                              = "./vpc/eu-central-1"
  region                              = "eu-central-1"
  c1_stand                            = var.c1_stand
  c1_region_code                      = "euc1"
  c1_prod_aws_backup_service_role_arn = aws_iam_role.c1_prod_aws_backup_service_role.arn
  providers = {
    #        aws.eu-central-1 = aws
    aws = aws
  }
}

module "vpc_ap_northeast_1" {
  source                              = "./vpc/ap-northeast-1"
  region                              = "ap-northeast-1"
  c1_company_code                     = var.c1_company_code
  c1_stand                            = var.c1_stand
  c1_region_code                      = "apne1"
  c1_prod_aws_backup_service_role_arn = aws_iam_role.c1_prod_aws_backup_service_role.arn
  providers = {
    aws = aws.ap-northeast-1
  }
}