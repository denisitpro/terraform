provider "cloudflare" {
  api_token = var.c99_devops_CF_API_RW_TOKEN
}

provider "aws" {
  region     = "eu-central-1"
  access_key = var.c99_devops_AWS_ACCESS_KEY
  secret_key = var.c99_devops_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = local.c99_company_code
      Stand    = var.c99_stand
      Region   = "eu-central-1"
      Location = "Frankfurt"
    }
  }
}

provider "aws" {
  region     = "eu-west-2"
  alias      = "eu-west-2"
  access_key = var.c99_devops_AWS_ACCESS_KEY
  secret_key = var.c99_devops_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = local.c99_company_code
      Stand    = var.c99_stand
      Region   = "eu-west-2"
      Location = "London"
    }
  }
}
