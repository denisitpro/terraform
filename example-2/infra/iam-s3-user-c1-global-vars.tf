/* todo remove */
# Create an IAM user
resource "aws_iam_user" "c1_s3_global_var_rw" {
  name = "s3-global-var-rw"
  tags = {
    Name      = "euc1-${var.c1_stand}-s3-globa-var-rw"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}

# Create an IAM policy for S3 access to the specific bucket
resource "aws_iam_policy" "c1_s3_access_policy" {
  name = "c1-s3-access-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:ListBucket"],
      Resource = [
        #        aws_s3_bucket.s3_bucket_c1_global_vars_v3.arn,
        aws_s3_bucket.c1_s3_global_vars_v4.arn
      ]
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = [
          #          join("/", [aws_s3_bucket.s3_bucket_c1_global_vars_v3.arn, "*"]),
          join("/", [aws_s3_bucket.c1_s3_global_vars_v4.arn, "*"])
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
          aws_dynamodb_table.c1_dynamon_global_vars_v4.arn
        ]
      }
    ]
  })
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "s3_user_policy_attachment" {
  user       = aws_iam_user.c1_s3_global_var_rw.name
  policy_arn = aws_iam_policy.c1_s3_access_policy.arn
}



/* create RO user */
resource "aws_iam_user" "c1_s3_global_var_ro" {
  name = "s3-global-var-ro"
  tags = {
    Name      = "euc1-${var.c1_stand}-s3-globa-var-ro"
    Createdby = local.c1_author_devops
    Owner     = local.c1_tag_owner_devops
  }
}


resource "aws_iam_policy" "c1_s3_policy_ro_bucket_c1_global_vars_v3" {
  name = "c1-s3-policy-ro-bucket_c1_global_vars_v3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:ListBucket"],
      Resource = [
        #        aws_s3_bucket.s3_bucket_c1_global_vars_v3.arn,
        aws_s3_bucket.c1_s3_global_vars_v4.arn
      ]
      },
      {
        Effect = "Allow",
        Action = ["s3:GetObject"],
        Resource = [
          #          join("/", [aws_s3_bucket.s3_bucket_c1_global_vars_v3.arn, "*"]),
          join("/", [aws_s3_bucket.c1_s3_global_vars_v4.arn, "*"])
        ]
    }]
  })
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "c1_c1_s3_global_var_rw_attach" {
  user       = aws_iam_user.c1_s3_global_var_ro.name
  policy_arn = aws_iam_policy.c1_s3_policy_ro_bucket_c1_global_vars_v3.arn
}