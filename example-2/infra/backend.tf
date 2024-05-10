terraform {
  backend "s3" {
    bucket         = "c1-s3-backend-euc1-c1-infra-g2"
    key            = "v2/c1-infra-euc1-v2.tfstate"
    region         = "eu-central-1"
    profile        = "c1_infra_s3_c1_infra_euc1_rw"
    encrypt        = true
    dynamodb_table = "c1_infra_euc1_v2_locks"
  }
}


/* read configure aws profile
https://developer.hashicorp.com/terraform/language/settings/backends/s3#profile */
data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket  = "c1-s3-global-vars-v1"
    key     = "v1/global-vars-v4.tfstate"
    region  = "eu-central-1"
    profile = "c1_global_ro"
  }
}