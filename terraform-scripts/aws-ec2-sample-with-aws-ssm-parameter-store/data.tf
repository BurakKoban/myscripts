data "aws_ssm_parameter" "vpc_id" {
  provider = aws.ssm
  name     = "/devops/aws/200934923951/ca-central-1/vpc/vpc_id"
}



data "aws_ssm_parameter" "subnet_id_list" {
  provider = aws.ssm
  name     = "/devops/aws/200934923951/ca-central-1/vpc/vpc-0e90b418d6a302101/private_subnets"
}

data "aws_ssm_parameter" "kms_key_arn" {
  provider = aws.ssm
  name     = "/devops/aws/200934923951/ca-central-1/kms/ebs_key_arn"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}