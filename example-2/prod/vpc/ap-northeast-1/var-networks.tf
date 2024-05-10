variable "c1_prod_apne1_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}


variable "c1_prod_apne1_public_subnet_cidrs" {
  type        = list(string)
  description = "c1-prod-apne1 public subnet CIDR values"
  default     = ["10.99.16.0/20", "10.99.32.0/20", "10.99.48.0/20"]
}

/* todo remove */
variable "c1_prod_apne1_egw_pub_net_cidrs" {
  type        = list(string)
  description = "exchange gateway cidr ipv4"
  default     = ["10.99.2.0/24"]
}


#variable "c1_prod_apne1_private_subnet_cidrs" {
#  type        = list(string)
#  description = "c1-prod-apne1 private subnet CIDR values"
#  default     = ["10.99.128.0/20", "10.99.144.0/20", "10.99.160.0/20"]
#}

variable "c1_prod_apne1_vpc_cidr" {
  description = "c1-prod-apne1 all subnets"
  default     = "10.99.0.0/16"
}

/* route network provider to binance DO-2242 */
variable "c1_prod_apne1_egw_provider_subnet_cidrs24" {
  description = "c1-prod-apne1 exchange gateway avelecom to binance network"
  default     = "10.200.1.0/24"
}
