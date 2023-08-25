variable "c99_devops_euc99_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}


variable "c99_devops_euc99_public_subnet_cidrs" {
  type        = list(string)
  description = "c99-devops-euc1 public subnet CIDR values"
  default     = ["10.225.16.0/20", "10.225.32.0/20", "10.225.48.0/20"]
}

variable "c99_devops_euc99_private_subnet_cidrs" {
  type        = list(string)
  description = "c99-devops-euc1 private subnet CIDR values"
  default     = ["10.225.128.0/20", "10.225.144.0/20", "10.225.160.0/20"]
}

variable "c99_devops_euc99_vpc_cidr" {
  description = "c99-devops-euc1 all subnets"
  default     = "10.225.0.0/16"
}

