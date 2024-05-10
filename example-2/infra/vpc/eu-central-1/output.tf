output "current_account" {
  value = {
    id  = data.aws_caller_identity.current.account_id
    arn = data.aws_caller_identity.current.arn
  }
}

output "current_region_id" {
  value = data.aws_region.current.id
}

output "euc1_c1_infra_vpc_id" {
  value = aws_vpc.c1_infra_euc1.id
}

output "euc1_c1_infra_vpc_arn" {
  value = aws_vpc.c1_infra_euc1.arn
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "public_subnet_ids" {
  value = aws_subnet.c1_infra_euc1_public_subnets[*].id
}
