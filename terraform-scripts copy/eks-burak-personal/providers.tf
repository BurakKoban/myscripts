provider "aws" {
  region                   = var.region
  access_key = "access_key"
  secret_key = "access_secret"

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
}
