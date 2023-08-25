variable "region" {
  description = "The AWS region"
  type        = string
}

variable "c99_company_code" {
  description = "Company code"
  type        = string
}

variable "c99_stand" {
  description = "Stand name"
  type        = string
}

variable "c99_region_code" {
  description = "Region code"
  type        = string
}

variable "c99_global_var_access_key" {
  type      = string
  sensitive = true
}

variable "c99_global_var_secret_key" {
  type      = string
  sensitive = true
}