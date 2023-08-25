output "euc99_ami_ubuntu_2204" {
  value = module.ec2_vm_euc99_c99_devops.current_ami_ubuntu_2204
}

output "euc99_region_id" {
  value = module.vpc_eu_central_1.current_region_id
}

output "euc99_account_id" {
  value = module.vpc_eu_central_1.current_account
}

output "euc99_c99_devops_vpc_arn" {
  value = module.vpc_eu_central_1.euc99_c99_devops_vpc_arn
}

output "euc99_az_list" {
  value = module.vpc_eu_central_1.data_aws_availability_zones
}

output "euc99_c99_devops_public_subnet_ids" {
  value = module.vpc_eu_central_1.public_subnet_ids
}

output "euc99_c99_devops_private_subnet_ids" {
  value = module.vpc_eu_central_1.private_subnet_ids
}

output "ip_mgmt_c99_devops_euc99_admins" {
  value = module.ec2_vm_euc99_c99_devops.mgmt_host_data
}

/* for backup */
output "c99_devops_aws_backup_service_role_arn" {
  value       = aws_iam_role.c99_devops_aws_backup_service_role.arn
  description = "The ARN of the c99-devops backup service role"
}
