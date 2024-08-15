data "aws_ssm_parameter" "vpc_id" {
  provider = aws.ssm
  name = "/devops/aws/675097064651/us-west-2/vpc/vpc-id"
}



data "aws_ssm_parameter" "subnet_id_list" {
  provider = aws.ssm
  name = "/devops/aws/675097064651/us-west-2/vpc/vpc-0e17c1830e7450f27/app-subnets"
}


data "aws_ami" "amzn-linux-2023-ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}