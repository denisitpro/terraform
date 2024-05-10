variable "region" {
  description = "The AWS region"
  type        = string
}

variable "c1_stand" {
  description = "Stand name"
  type        = string
}

variable "c1_region_code" {
  description = "Region code"
  type        = string
}

variable "c1_infra_IPSEC_PRESHARE_KEY" {
  type      = string
  sensitive = true
}

variable "wg_interface_id" {
  type      = string
  sensitive = true
}

variable "c1_infra_aws_backup_service_role_arn" {
  description = "backup arn iam policy"
  type        = string
}
