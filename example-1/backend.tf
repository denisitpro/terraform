terraform {
  backend "http" {}
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket     = "c99-infra-euc1-global-vars"
    key        = "v1/global.tfstate"
    region     = "eu-central-1"
    access_key = var.c99_GLOBAL_VAR_ACCESS_KEY
    secret_key = var.c99_GLOBAL_VAR_SECRET_KEY
  }
}