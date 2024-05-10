locals {
  # todo remove
  c1_ssh_keys_devops_euc1         = module.euc1_ssh_devops_ed25519.current_ssh_key_name
  c1_ssh_keys_devops_ed25519_euc1 = module.euc1_ssh_devops_ed25519.current_ssh_key_name
  c1_ssh_keys_devops_rsa_euc1     = module.euc1_ssh_devops_rsa.current_ssh_key_name
}
