data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket     = "c99-infra-euc1-global-vars"
    key        = "v1/global.tfstate"
    region     = "eu-central-1"
    access_key = var.c99_global_var_access_key
    secret_key = var.c99_global_var_secret_key
  }
}