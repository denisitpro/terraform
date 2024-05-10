# Configure the AWS Provider
/* default provider*/
provider "aws" {
  region     = "eu-central-1"
  access_key = var.c1_prod_AWS_ACCESS_KEY
  secret_key = var.c1_prod_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = var.c1_company_code
      Stand    = var.c1_stand
      Region   = "eu-central-1"
      Location = "Frankfurt"
      #      ManagedBy = "Terraform"
    }
  }
}
provider "aws" {
  region     = "eu-west-1"
  alias      = "eu-west-1"
  access_key = var.c1_prod_AWS_ACCESS_KEY
  secret_key = var.c1_prod_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = var.c1_company_code
      Stand    = var.c1_stand
      Region   = "eu-west-1"
      Location = "Ireland"
      #      ManagedBy = "Terraform"
    }
  }
}

provider "aws" {
  region     = "eu-west-2"
  alias      = "eu-west-2"
  access_key = var.c1_prod_AWS_ACCESS_KEY
  secret_key = var.c1_prod_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = var.c1_company_code
      Stand    = var.c1_stand
      Region   = "eu-west-2"
      Location = "London"
    }
  }
}

provider "aws" {
  alias      = "ap-east-1"
  region     = "ap-east-1"
  access_key = var.c1_prod_AWS_ACCESS_KEY
  secret_key = var.c1_prod_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = var.c1_company_code
      Stand    = var.c1_stand
      Region   = "ap-east-1"
      Location = "Hong Kong"
    }
  }
}


provider "aws" {
  alias      = "ap-northeast-1"
  region     = "ap-northeast-1"
  access_key = var.c1_prod_AWS_ACCESS_KEY
  secret_key = var.c1_prod_AWS_SECRET_KEY
  default_tags {
    tags = {
      Code     = var.c1_company_code
      Stand    = var.c1_stand
      Region   = "ap-northeast-1"
      Location = "Tokyo"
    }
  }
}

provider "cloudflare" {
  api_token = var.c1_prod_CF_API_RW_TOKEN
}