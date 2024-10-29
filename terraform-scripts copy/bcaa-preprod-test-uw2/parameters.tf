data "aws_caller_identity" "current" {}
data "aws_caller_identity" "ssm" { provider = aws.devops }
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

# Get latest Windows Server 2022 AMI
data "aws_ami" "win2022server" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }

  filter {
    name   = "platform"
    values = ["windows"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

### SSM Parameters Input
data "aws_ssm_parameter" "vpc_id" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/vpc_id"
}

data "aws_ssm_parameter" "private_subnets" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/${local.vpc_id}/private_subnets"
}

data "aws_ssm_parameter" "key_pair_name" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/ec2/key_pair_name"
}
