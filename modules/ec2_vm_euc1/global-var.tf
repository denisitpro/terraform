locals {
  c99_company_code      = data.terraform_remote_state.global.outputs.c99_company_code
  c99_author_denisitpro = data.terraform_remote_state.global.outputs.c99_author_denisitpro

  c99_denisitpro_public_key = data.terraform_remote_state.global.outputs.ssh_keys.c99_denisitpro_public_key

  c99_teleport_cls_name = data.terraform_remote_state.global.outputs.c99_teleport_cls_name

  c99_tag_owner_devops = data.terraform_remote_state.global.outputs.c99_tag_owner_devops

  c99_infra_euc99_mgmt_cidr = data.terraform_remote_state.global.outputs.c99_infra_euc99_mgmt_cidr

  c99_prom_cidr = data.terraform_remote_state.global.outputs.c99_prom_cidr
  c99_zbx_cidr  = data.terraform_remote_state.global.outputs.c99_zbx_cidr

  ports_consul         = data.terraform_remote_state.global.outputs.ports_consul
  port_egress_tcp_all  = data.terraform_remote_state.global.outputs.port_egress_tcp_all
  port_egress_udp_all  = data.terraform_remote_state.global.outputs.port_egress_udp_all
  port_egress_ipa_both = data.terraform_remote_state.global.outputs.port_egress_ipa_both
  port_egress_ctb      = data.terraform_remote_state.global.outputs.port_egress_ctb
  ports_http           = data.terraform_remote_state.global.outputs.ports_http

  c99_devops_aws_account_id = data.terraform_remote_state.global.outputs.aws_accounts.c99_devops_aws_account_id

  tgw_c99_devel_euw2 = data.terraform_remote_state.global.outputs.aws_tgw.tgw_c99_devel_euw2

}
