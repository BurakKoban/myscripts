data "aws_caller_identity" "current" {}
data "aws_caller_identity" "ssm" { provider = aws.devops }
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}



data "aws_ssm_parameter" "vpc_id" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/vpc_id"
}

data "aws_ssm_parameter" "vpc_cidr_block" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/${local.vpc_id}/vpc_cidr_block"
}

data "aws_ssm_parameter" "private_subnets" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/${local.vpc_id}/private_subnets"
}

data "aws_ssm_parameter" "intra_subnets" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/${local.vpc_id}/intra_subnets"
}

