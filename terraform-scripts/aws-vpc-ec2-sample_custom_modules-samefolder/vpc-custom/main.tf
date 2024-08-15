resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cdir
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_subnet_1

  tags = {
    Name = "Private_Subnet_1"
  }
}