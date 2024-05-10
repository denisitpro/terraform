module "euc1_ssh_devops" {
  source                  = "git@github.com:example-com/tf-ssh-module.git//ssh-keypair?ref=1.0"
  aws_key_pair_key_name   = "c1_devops_ssh_pub"
  aws_key_pair_public_key = local.c1_devops_public_key
  aws_key_pair_tags = {
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
  providers = {
    aws = aws
  }
}
