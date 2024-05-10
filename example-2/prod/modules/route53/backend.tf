#data "terraform_remote_state" "global" {
#  backend = "s3"
#  config = {
#    bucket     = "c1-infra-euc1-global-vars-v1"
#    key        = "v1/global.tfstate"
#    region     = "eu-central-1"
#    access_key = var.c1_global_var_access_key
#    secret_key = var.c1_global_var_secret_key
#  }
#}