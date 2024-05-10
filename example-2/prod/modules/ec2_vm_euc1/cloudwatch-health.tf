variable "c1_instance_ids_failure" {
  type        = list(string)
  description = "List of EC2 Instance IDs to monitor"
  default     = ["i-0948ebb21da3670ee"]
}

resource "aws_cloudwatch_metric_alarm" "c1_status_check_failed_system" {
  count               = length(var.c1_instance_ids_failure)
  alarm_name          = "${var.c1_region_code}-${var.c1_stand}-status-check-failed-system-${var.c1_instance_ids_failure[count.index]}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "Trigger a recovery action when system status check fails for ${var.c1_instance_ids_failure[count.index]}"
  actions_enabled     = true
  /* need set corrected region */
  alarm_actions             = ["arn:aws:automate:eu-central-1:ec2:recover", aws_sns_topic.c1_server_failed.arn]
  ok_actions                = [aws_sns_topic.c1_server_failed.arn]
  insufficient_data_actions = [aws_sns_topic.c1_server_failed.arn]

  dimensions = {
    InstanceId = var.c1_instance_ids_failure[count.index]
  }
}

resource "aws_sns_topic" "c1_server_failed" {
  name = "${var.c1_region_code}-${var.c1_stand}-server-failed-watch"
}

resource "aws_sns_topic_subscription" "c1_email_notification" {
  topic_arn = aws_sns_topic.c1_server_failed.arn
  protocol  = "email"
  endpoint  = "server-reboot-notify@ci-id.net"
}