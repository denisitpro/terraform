#docs  https://shadabambat1.medium.com/automatically-backup-your-ec2-instances-using-aws-backups-terraform-c06d15e2a9c2

/* Assume Role Policy for Backups */
data "aws_iam_policy_document" "c1_prod_aws_backup_service_assume_role_policy_doc" {
  statement {
    sid     = "AssumeServiceRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

/* The policies that allow the backup service to take backups and restores */
data "aws_iam_policy" "c1_prod_aws_backup_service_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

data "aws_iam_policy" "c1_aws_restore_service_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

data "aws_caller_identity" "current_account" {}

/* Needed to allow the backup service to restore from a snapshot to an EC2 instance
 See https://stackoverflow.com/questions/61802628/aws-backup-missing-permission-iampassrole */
data "aws_iam_policy_document" "c1_pass_role_policy_doc" {
  statement {
    sid       = "c1PassRole"
    actions   = ["iam:PassRole"]
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_account.account_id}:role/*"]
  }
}

/* Roles for taking AWS Backups */
resource "aws_iam_role" "c1_prod_aws_backup_service_role" {
  name               = "c1AWSBackupServiceRole"
  description        = "Allows the AWS Backup Service to take scheduled backups"
  assume_role_policy = data.aws_iam_policy_document.c1_prod_aws_backup_service_assume_role_policy_doc.json

  tags = {
    Name        = "c1 backup service role"
    Role        = "iam"
    Code        = var.c1_company_code
    Environment = var.c1_stand
    Createdby   = local.c1_author_devops
  }
}

resource "aws_iam_role_policy" "c1_backup_service_aws_backup_role_policy" {
  policy = data.aws_iam_policy.c1_prod_aws_backup_service_policy.policy
  role   = aws_iam_role.c1_prod_aws_backup_service_role.name
}

resource "aws_iam_role_policy_attachment" "c1_restore_service_aws_backup_role_policy_attachment" {
  policy_arn = data.aws_iam_policy.c1_aws_restore_service_policy.arn
  role       = aws_iam_role.c1_prod_aws_backup_service_role.name
}


resource "aws_iam_role_policy" "c1_backup_service_pass_role_policy" {
  policy = data.aws_iam_policy_document.c1_pass_role_policy_doc.json
  role   = aws_iam_role.c1_prod_aws_backup_service_role.name
}