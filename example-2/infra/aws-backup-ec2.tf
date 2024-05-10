#locals {
#  backups = {
#    schedule = "cron(0 2 * * ? *)" # Run every day at 02:00 UTC
#    #    schedule  = "cron(0 */4 * * ? *)" # Run every 4 hours
#    retention = 7 # 7 days retention
#  }
#}
#
#
#
#resource "aws_backup_vault" "c1_infra_backup_vault" {
#  name = "c1_infra_backup_vault"
#  tags = {
#    Name      = "${var.c1_stand} backup vault"
#    Code      = local.c1_company_code
#    Createdby = local.c1_author_devops
#    Role      = "backup_vault"
#  }
#}
#
#resource "aws_backup_plan" "c1_infra_backup_plan" {
#  name = "c1_infra_backup_plan"
#
#  rule {
#    rule_name         = "c1_infra_ec2_backup_${local.backups.retention}_day_retention"
#    target_vault_name = aws_backup_vault.c1_infra_backup_vault.name
#    schedule          = local.backups.schedule
#    start_window      = 60
#    completion_window = 300
#
#    lifecycle {
#      delete_after = local.backups.retention
#    }
#
#    recovery_point_tags = {
#      Name      = "${var.c1_stand} backup plan recovery tag"
#      Code      = local.c1_company_code
#      Createdby = local.c1_author_devops
#      Creator   = "aws_backups"
#    }
#  }
#
#  tags = {
#    Name      = "${var.c1_stand} backup backup plan"
#    Code      = local.c1_company_code
#    Createdby = local.c1_author_devops
#    Role      = "backup"
#  }
#}
#
#resource "aws_backup_selection" "c1_infra_server_backup_selection" {
#  iam_role_arn = aws_iam_role.c1_infra_aws_backup_service_role.arn
#  name         = "c1_infra_server_backup_selection"
#  plan_id      = aws_backup_plan.c1_infra_backup_plan.id
#
#  selection_tag {
#    type  = "STRINGEQUALS"
#    key   = "Backup"
#    value = "true"
#  }
#}
#
