provider "aws" {
  region                   = var.region
  profile                  = var.default_profile
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
}

provider "aws" {
  alias                    = "devops"
  region                   = "ca-central-1"
  profile                  = "automation"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}