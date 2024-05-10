module "c1_s3_backup_long_v1" {
  source          = "git@github.com:example-com/tf-s3-backup-module.git//s3-backup?ref=1.1.0"
  bucket          = "c1-s3-backup-long-v1"
  expiration_days = "270"
  tags = {
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
    Task      = "DO-1924"
  }
  providers = {
    aws = aws
  }
}