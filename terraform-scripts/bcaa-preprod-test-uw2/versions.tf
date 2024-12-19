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
    profile        = "automation"
    region         = "us-west-2"
    bucket         = "burak-terraform-state-testbucket"
    dynamodb_table = "burak-test-terraform-state-lock"
    key            = "single-account/bcaapreprod/bcaa-preprod-test-uw2/terraform.tfstate"
    encrypt        = true #AES-256 encryption
  }

}