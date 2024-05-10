output "current_account" {
  value = {
    id  = data.aws_caller_identity.current.account_id
    arn = data.aws_caller_identity.current.arn
  }
}

output "current_region_id" {
  value = data.aws_region.current.id
}

output "euc99_c99_devops_vpc_id" {
  value = aws_vpc.c99_devops_euc1.id
}

output "euc99_c99_devops_vpc_arn" {
  value = aws_vpc.c99_devops_euc1.arn
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "public_subnet_ids" {
  value = aws_subnet.c99_devops_euc99_public_subnets[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.c99_private_euc99_subnets[*].id
}
