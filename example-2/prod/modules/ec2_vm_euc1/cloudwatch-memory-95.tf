/* memory notify section */
variable "c1_instance_ids_memory" {
  description = "List of EC2 Instance IDs"
  type        = list(string)
  default     = ["i-sd1123123"]
}

resource "aws_cloudwatch_metric_alarm" "c1_high_memory_usage" {
  for_each = toset(var.c1_instance_ids_memory)

  alarm_name          = "${var.c1_region_code}-${var.c1_stand}-high-memory-usage-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "95"
  alarm_description   = "Alarm when memory usage exceeds 95%"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.c1_memory_notification.arn, aws_sns_topic.c1_server_reboot.arn]
  ok_actions          = [aws_sns_topic.c1_memory_notification.arn]

  dimensions = {
    InstanceId = each.key
  }
  tags = {
    Name  = "${var.c1_region_code}-${var.c1_stand}-memory-alarm"
    Owner = local.c1_tag_owner_devops
  }
}


/* topic for email notify */
resource "aws_sns_topic" "c1_memory_notification" {
  name = "${var.c1_region_code}-${var.c1_stand}-memory-usage-notification"
}

resource "aws_sns_topic_subscription" "c1_memory_notification_sub" {
  topic_arn = aws_sns_topic.c1_memory_notification.arn
  protocol  = "email"
  endpoint  = "server-reboot-notify@ci-id.net" // Замените на ваш email
}

/* topic for reboot */
resource "aws_sns_topic" "c1_server_reboot" {
  name = "${var.c1_region_code}-${var.c1_stand}-server-reboot-lamda"
}



/* Iam role for allow push */
resource "aws_iam_policy" "c1_cloudwatch_agent_policy" {
  name        = "${var.c1_region_code}-${var.c1_stand}-CloudWatchAgentPolicy"
  path        = "/"
  description = "Allow CloudWatch Agent to push metrics"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeTags",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "c1_cloudwatch_agent_attachment" {
  role       = aws_iam_role.c1_cloudwatch_agent_role.name
  policy_arn = aws_iam_policy.c1_cloudwatch_agent_policy.arn
}

resource "aws_iam_role" "c1_cloudwatch_agent_role" {
  name = "${var.c1_region_code}-${var.c1_stand}-CloudWatchAgentRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


/* role for association */
resource "aws_iam_instance_profile" "c1_cloudwatch_agent_profile" {
  name = "${var.c1_region_code}-${var.c1_stand}-CloudWatchAgentProfile"
  role = aws_iam_role.c1_cloudwatch_agent_role.name
}


/* step for reboot */
resource "aws_lambda_function" "c1_reboot_instance" {
  function_name = "${var.c1_region_code}-${var.c1_stand}-reboot_instance"
  role          = aws_iam_role.c1_lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  filename      = "${path.module}/files/reboot-v3.zip"
}


resource "aws_iam_policy" "c1_lambda_reboot_policy" {
  name        = "${var.c1_region_code}-${var.c1_stand}-lambda_reboot_policy"
  description = "IAM policy for rebooting EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:RebootInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "c1_lambda_reboot_policy_attachment" {
  role       = aws_iam_role.c1_lambda_exec_role.name
  policy_arn = aws_iam_policy.c1_lambda_reboot_policy.arn
}

/* lamda function iam role */
resource "aws_iam_role" "c1_lambda_exec_role" {
  name = "${var.c1_region_code}-${var.c1_stand}-lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.c1_region_code}-${var.c1_stand}-lambda-policy"
  role = aws_iam_role.c1_lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:RebootInstances",
          "ec2:DescribeInstances"
        ],
        Resource = "*",
        Effect   = "Allow"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*",
        Effect   = "Allow"
      }
    ]
  })
}

/* subscribe lamda function to topic sns */
resource "aws_sns_topic_subscription" "c1_lambda_subscription" {
  topic_arn = aws_sns_topic.c1_server_reboot.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.c1_reboot_instance.arn
}

resource "aws_lambda_permission" "c1_allow_sns_invoke" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.c1_reboot_instance.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.c1_server_reboot.arn
}

