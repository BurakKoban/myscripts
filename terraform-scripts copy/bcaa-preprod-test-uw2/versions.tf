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
    profile        = "automation_tf"
    region         = "us-west-2"
    bucket         = "bcaa-automation-terraform-state"
    dynamodb_table = "bcaa-automation-terraform-state-lock"
    key            = "single-account/ec2-project/bcaa-preprod-test-uw2/terraform.tfstate"
    encrypt        = true #AES-256 encryption
  }

}