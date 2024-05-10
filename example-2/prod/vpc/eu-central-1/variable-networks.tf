variable "c1_prod_euc1_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}


variable "c1_prod_euc1_public_subnet_cidrs" {
  type        = list(string)
  description = "c1-prod-euc1 public subnet CIDR values"
  default     = ["10.101.16.0/20", "10.101.32.0/20", "10.101.48.0/20"]
}

#variable "c1_prod_euc1_private_subnet_cidrs" {
#  type        = list(string)
#  description = "c1-prod-euc1 private subnet CIDR values"
#  default     = ["10.101.128.0/20", "10.101.144.0/20", "10.101.160.0/20"]
#}

variable "c1_prod_euc1_vpc_cidr" {
  description = "c1-prod-euc1 all subnets"
  default     = "10.101.0.0/16"
}

