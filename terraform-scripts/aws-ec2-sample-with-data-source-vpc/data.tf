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

data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = ["QA-API-VPC"]
  }
}

/* data "aws_subnet" "my_subnet" {
  filter {
    name   = "tag:Name"
    values = ["app_a"]
  }
}
*/

data "aws_subnets" "my_subnets" {
  filter {
    name = "tag:Name"
    values = [
      "app_a", 
      "app_b",
      "app_c"
    ]
  }
}


