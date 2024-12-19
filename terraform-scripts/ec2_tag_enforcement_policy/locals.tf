locals {
  name            = replace(basename(path.cwd), "_", "-")
  #namespace       = split("-", local.name)[0]
  #stage           = join("-", [split("-", local.name)[1], split("-", local.name)[2]])
  default_region  = var.region
  
  
  tags = {
    Environment = "AWS Organizations"
    Created_By  = "Terraform"
    Owner       = "Ryan Degner"
    Department  = "IS"
    Creator     = "Burak Koban"
    
  }
}
