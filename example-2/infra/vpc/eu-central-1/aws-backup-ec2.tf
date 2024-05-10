locals {
  backups = {
    schedule  = "cron(0 3 * * ? *)" # Run every day at 02:00 UTC
    retention = 7                   # 7 days retention
  }
}



resource "aws_backup_vault" "c1_infra_euc1_backup_vault" {
  name = "c1_infra_euc1_backup_vault"
  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code} backup vault"
    Role      = "backup_vault"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
  }
}

resource "aws_backup_plan" "c1_infra_euc1_backup_plan" {
  name = "c1_infra_euc1_backup_plan"

  rule {
    rule_name         = "c1_ec2_backup_${local.backups.retention}_day_retention"
    target_vault_name = aws_backup_vault.c1_infra_euc1_backup_vault.name
    schedule          = local.backups.schedule
    start_window      = 60
    completion_window = 300

    lifecycle {
      delete_after = local.backups.retention
    }

    recovery_point_tags = {
      Name      = "${var.c1_stand}-${var.c1_region_code}  backup plan recovery tag"
      Code      = local.c1_company_code
      Createdby = local.c1_author_devops
    }
  }

  tags = {
    Name      = "${var.c1_stand}-${var.c1_region_code}  backup backup plan"
    Code      = local.c1_company_code
    Createdby = local.c1_author_devops
    Role      = "backup"
  }
}

resource "aws_backup_selection" "c1_server_backup_selection" {
  iam_role_arn = var.c1_infra_aws_backup_service_role_arn
  name         = "c1_infra_euc1_server_resources"
  plan_id      = aws_backup_plan.c1_infra_euc1_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}

