provider "aws" {
  alias   = "ssm"
  region  = "ca-central-1"
  profile = "automation"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

data "aws_ssm_parameter" "my_string" {
  provider = aws.ssm
  name = "/devops/aws/474372112003/us-west-2/vpc/vpc-1cba997a/cidr"
}

output "my_string" {
 sensitive = true
 value = data.aws_ssm_parameter.my_string.value
}

data "aws_ssm_parameter" "my_stringlist" {
  provider = aws.ssm
  name = "/devops/aws/474372112003/us-west-2/vpc/vpc-1cba997a/dmz_subnets"
}

output "my_stringlist1" {
 sensitive = true
 value = data.aws_ssm_parameter.my_stringlist.value
}

output "my_stringlist2" {
 #sensitive = true
 value = nonsensitive(split(",",data.aws_ssm_parameter.my_stringlist.value)[0])
}
