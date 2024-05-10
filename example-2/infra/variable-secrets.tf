variable "C1_INFRA_AWS_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "C1_INFRA_AWS_SECRET_KEY" {
  type      = string
  sensitive = true
}

variable "CF_CI_Q9_API_RW_TOKEN" {
  type      = string
  sensitive = true
}

variable "CF_CI_HTZ_API_RW_TOKEN" {
  type      = string
  sensitive = true
}

variable "c1_infra_IPSEC_PRESHARE_KEY" {
  type      = string
  sensitive = true
}
#/* GLOBAL VARS RO only*/
#variable "C1_GLOBAL_VAR_ACCESS_KEY" {
#  type      = string
#  sensitive = true
#}
#
#variable "C1_GLOBAL_VAR_SECRET_KEY" {
#  type      = string
#  sensitive = true
#}