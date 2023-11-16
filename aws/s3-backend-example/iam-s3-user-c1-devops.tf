/* todo remove */
# Create an IAM user
resource "aws_iam_user" "s3_devops_rw" {
  name = "s3-devops-rw"
  tags = {
    Name      = "eu${var.stand} devops-s3-user"
    Createdby = local.author_example
    Owner     = local.tag_owner_devops
  }
}

# Create an IAM policy for S3 access to the specific bucket
resource "aws_iam_policy" "s3_policy_devops_rw" {
  name = "s3-devops-access-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:ListBucket"],
      Resource = [
        aws_s3_bucket.s3_devops_v2.arn
      ]
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = [
          join("/", [aws_s3_bucket.s3_devops_v2.arn, "*"])
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
        ],
        Resource = [
          aws_dynamodb_table.dynamodb_devops_v2.arn
        ]
      }
    ]
  })
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "s3_policy_attch_devops_rw" {
  user       = aws_iam_user.s3_devops_rw.name
  policy_arn = aws_iam_policy.s3_policy_devops_rw.arn
}

