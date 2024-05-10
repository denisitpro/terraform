locals {
  c1_company_code             = data.terraform_remote_state.global.outputs.c1_company_code
  c1_author_devops             = data.terraform_remote_state.global.outputs.c1_author_devops
  c1_devops_public_key = data.terraform_remote_state.global.outputs.ssh_keys.c1_devops_public_key
  c1_devops_rsa_key    = data.terraform_remote_state.global.outputs.ssh_keys.c1_devops_rsa_key

  c1_teleport_cls_name = data.terraform_remote_state.global.outputs.c1_teleport_cls_name

  c1_tag_owner_devops               = data.terraform_remote_state.global.outputs.c1_tag_owner_devops

  c1_infra_euc1_mgmt_cidr = data.terraform_remote_state.global.outputs.c1_infra_euc1_mgmt_cidr
  c1_devel_euc1_mgmt_cidr = data.terraform_remote_state.global.outputs.c1_devel_euc1_mgmt_cidr
  c1_prod_euc1_mgmt_cidr  = data.terraform_remote_state.global.outputs.c1_prod_euc1_mgmt_cidr

  c1_prom_cidr                     = data.terraform_remote_state.global.outputs.c1_prom_cidr
  c1_zbx_cidr                      = data.terraform_remote_state.global.outputs.c1_zbx_cidr
  c1_infra_euc1_grafana_15_cidr4   = data.terraform_remote_state.global.outputs.c1_infra_euc1_grafana_15_cidr4
  c1_infra_euc1_gitlab_devel_cidr4 = data.terraform_remote_state.global.outputs.c1_infra_euc1_gitlab_devel_cidr4


  ports_consul         = data.terraform_remote_state.global.outputs.ports_consul
  port_egress_tcp_all  = data.terraform_remote_state.global.outputs.port_egress_tcp_all
  port_egress_udp_all  = data.terraform_remote_state.global.outputs.port_egress_udp_all
  port_egress_ipa_both = data.terraform_remote_state.global.outputs.port_egress_ipa_both
  ports_http           = data.terraform_remote_state.global.outputs.ports_http
  port_clickhouse      = data.terraform_remote_state.global.outputs.port_clickhouse

  c1_infra_aws_account_id  = data.terraform_remote_state.global.outputs.aws_accounts.c1_infra_aws_account_id
  c1_prod_aws_account_id   = data.terraform_remote_state.global.outputs.aws_accounts.c1_prod_aws_account_id

  tgw_c1_prod_euc1  = data.terraform_remote_state.global.outputs.aws_tgw.tgw_c1_prod_euc1
  tgw_c1_prod_euw1  = data.terraform_remote_state.global.outputs.aws_tgw.tgw_c1_prod_euw1
  tgw_c1_prod_euw2  = data.terraform_remote_state.global.outputs.aws_tgw.tgw_c1_prod_euw2
  tgw_c1_prod_ape1  = data.terraform_remote_state.global.outputs.aws_tgw.tgw_c1_prod_ape1
  tgw_c1_prod_apne1 = data.terraform_remote_state.global.outputs.aws_tgw.tgw_c1_prod_apne1

  c1_prod_euc1_cidr       = data.terraform_remote_state.global.outputs.c1_prod_euc1_cidr
  c1_prod_euw1_cidr       = data.terraform_remote_state.global.outputs.c1_prod_euw1_cidr
  c1_prod_euw2_cidr       = data.terraform_remote_state.global.outputs.c1_prod_euw2_cidr
  c1_prod_ape1_cidr       = data.terraform_remote_state.global.outputs.c1_prod_ape1_cidr
  c1_prod_apne1_cidr      = data.terraform_remote_state.global.outputs.c1_prod_apne1_cidr


  c1_infra_euc1_mgmt_cidr6    = data.terraform_remote_state.global.outputs.c1_infra_euc1_mgmt_cidr6
  c1_infra_fsn1_mgmt_cidr6    = data.terraform_remote_state.global.outputs.c1_infra_fsn1_mgmt_cidr6
  c1_infra_euc1_zbx_15_cidr6  = data.terraform_remote_state.global.outputs.c1_infra_euc1_zbx_15_cidr6
  c1_infra_euc1_prom_15_cidr6 = data.terraform_remote_state.global.outputs.c1_infra_euc1_prom_15_cidr6


  c1_infra_euc1_VPC_cidr56 = data.terraform_remote_state.global.outputs.c1_infra_euc1_VPC_cidr56

  c1_prod_euc1_VPC_cidr56  = data.terraform_remote_state.global.outputs.c1_prod_euc1_VPC_cidr56
  c1_prod_euw1_VPC_cidr56  = data.terraform_remote_state.global.outputs.c1_prod_euw1_VPC_cidr56
  c1_prod_euw2_VPC_cidr56  = data.terraform_remote_state.global.outputs.c1_prod_euw2_VPC_cidr56
  c1_prod_ape1_VPC_cidr56  = data.terraform_remote_state.global.outputs.c1_prod_ape1_VPC_cidr56
  c1_prod_apne1_VPC_cidr56 = data.terraform_remote_state.global.outputs.c1_prod_apne1_VPC_cidr56

  base_protocols = data.terraform_remote_state.global.outputs.base_protocols


}
