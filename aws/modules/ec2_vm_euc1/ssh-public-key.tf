resource "aws_key_pair" "c99_denisitpro_ssh_pub" {
  key_name   = "c99_denisitpro_ssh_pub"
  public_key = local.c99_denisitpro_public_key
  tags = {
    Name      = "SSH key user denisitpro"
    Createdby = local.c99_author_denisitpro
    Owner     = local.c99_tag_owner_devops
  }
}
