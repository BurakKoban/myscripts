terraform {
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }    
  }

  required_version = ">= 1.0.0"

  backend "s3" {
    profile              = "default"
    region               = "us-west-2"
    bucket               = "burak-terraform-state-testbucket"
    dynamodb_table       = "burak-test-terraform-state-lock"
    key                  = "multi-accounts-infra/multi-scp-policies/ec2-mandatorytag-scp/terraform.tfstate"
    encrypt              = true     #AES-256 encryption
  }  
 
}

##########################
###### AWS Providers #####
##########################

provider "aws" {
  region  = var.region            #us-west-2
  profile = var.default_profile   #AWS_Master 337558554106
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

provider "aws" {
  alias   = "automation"
  region  = var.region
  profile = "default"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}
