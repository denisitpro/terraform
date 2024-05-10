provider "cloudflare" {
  api_token = var.CF_EXAMPLE_API_RW_TOKEN
}


provider "aws" {
  region = "eu-central-1"
  #  alias      = "eu-central-1"
  access_key = var.C1_INFRA_AWS_ACCESS_KEY
  secret_key = var.C1_INFRA_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code       = local.c1_company_code
      Stand      = "c1-infra"
      Region     = "eu-central-1"
      Generation = "gen2"
      Location   = "Frankfurt"
      #      ManagedBy = "Terraform"
    }
  }
}