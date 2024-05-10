data "aws_ami" "ubuntu_2204_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

output "current_ami_ubuntu_2204" {
  value = {
    ami_id = data.aws_ami.ubuntu_2204_amazon.id
    name   = data.aws_ami.ubuntu_2204_amazon.name
  }
}

locals {
  current_region_ami_id = data.aws_ami.ubuntu_2204_amazon.id
}
