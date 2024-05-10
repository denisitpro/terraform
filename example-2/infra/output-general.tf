output "euc1_account_id" {
  value = module.vpc_eu_central_1.current_account
}

output "mgmt_c1_infra_euc1_admins" {
  value = module.ec2_vm_euc1_c1_infra.mgmt_host_data
}

/* for backup */
output "c1_s3_backup_long_v1" {
  value = module.c1_s3_backup_long_v1.current_s3_arn
}
#output "c1_infra_aws_backup_service_role_arn" {
#  value       = aws_iam_role.c1_infra_aws_backup_service_role.arn
#  description = "The ARN of the c1-infra backup service role"
#}
#
#/* wireguard network id */
#output "wg_interface_id" {
#  value = module.ec2_vm_euc1_c1_infra.wg_interface_id
#}