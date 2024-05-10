# ec2_instance/variables.tf

variable "public_subnet_ids" {
  description = "The VPC public subnet ID to launch in"
  type        = list(any)
  default     = null
}

#variable "private_subnet_ids" {
#  description = "The VPC private subnet ID to launch in"
#  type        = list(any)
#  default     = null
#}

variable "c1_region_code" {
  description = "Region code"
  type        = string
}

variable "user_data_path" {
  description = "Path to user-data"
  type        = string
}

variable "vpc_id" {
  type = string
}
