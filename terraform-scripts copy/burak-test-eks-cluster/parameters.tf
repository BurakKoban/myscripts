data "aws_caller_identity" "current" {}
data "aws_caller_identity" "ssm" { provider = aws.devops }
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

# Get latest AWS EKS AMI
data "aws_ami" "eks" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-eks-node-${local.cluster_version}-v*"]
  }

 #  filter {
 #    name   = "platform"
 #    values = ["Linux/UNIX"]
 #  }
 #
 #  filter {
 #    name   = "architecture"
 #    values = ["x86_64"]
 #  }
}


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

data "aws_ssm_parameter" "public_subnets" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/vpc/${local.vpc_id}/public_subnets"
}

data "aws_ssm_parameter" "key_pair_name" {
  provider = aws.devops
  name     = "/${local.ssm_base_path}/ec2/key_pair_name"
}