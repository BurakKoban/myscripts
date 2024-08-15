terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
backend "s3" {
    profile              = "default"
    region               = "us-west-2"
    bucket               = "burak-terraform-state-testbucket"
    dynamodb_table       = "burak-test-terraform-state-lock"
    key                  = "single-account/ms_qa/remote-state-vpc/ec2-module/terraform.tfstate"
    encrypt              = true     #AES-256 encryption
  }  

}

provider "aws" {
  region = "ca-central-1"
  profile = "ms_qa"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  # skip_metadata_api_check     = true
  # skip_region_validation      = true
  # skip_credentials_validation = true
  #skip_requesting_account_id  = true
}
