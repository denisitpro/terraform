resource "aws_s3_bucket" "s3_devops_v2" {
  bucket = "s3-devops-v2"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name      = "eu${var.stand} bucket devops v2"
    Createdby = local.author_example
    Owner     = local.tag_owner_devops
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership_devops_v2" {
  bucket = aws_s3_bucket.s3_devops_v2.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_acl_devops_v2" {
  bucket = aws_s3_bucket.s3_devops_v2.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.s3_ownership_devops_v2]
}


resource "aws_s3_bucket_versioning" "s3_versioning_devops_v2" {
  bucket = aws_s3_bucket.s3_devops_v2.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse_devops_v2" {
  bucket = aws_s3_bucket.s3_devops_v2.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle_devops_v2" {
  bucket = aws_s3_bucket.s3_devops_v2.id

  rule {
    id = "versioning-policy"

    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    #    transition {
    #      days          = 60
    #      storage_class = "GLACIER"
    #    }
    expiration {
      days = 90
    }
  }
}

resource "aws_dynamodb_table" "dynamodb_devops_v2" {
  name         = "devops_v2_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

#output "dynamodb_table_arn" {
#  value = aws_dynamodb_table.dynamon_devops_v2.arn
#}
