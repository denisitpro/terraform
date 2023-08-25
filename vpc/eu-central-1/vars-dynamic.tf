data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_availability_zones" "working" {}

locals {
  current_region_name = data.aws_region.current.name
}
