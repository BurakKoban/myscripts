module "label" {
  source      = "git::git@bitbucket.org:bcaacai/terraform-null-label?ref=tags/v0.1.1"
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  name        = var.name
  attributes  = var.attributes
  delimiter   = var.delimiter
  label_order = ["namespace", "stage", "environment", "name", "attributes"]
}

locals {
  name                    = replace(basename(path.cwd), "_", "-")
  default_region          = data.aws_region.current.name
  cluster_name            = module.label.id
  cluster_version         = var.cluster_version
  count_availability_zone = (length(data.aws_availability_zones.available.names) <= 3) ? length(data.aws_availability_zones.available.zone_ids) : 3
  azs                     = slice(data.aws_availability_zones.available.names, 0, local.count_availability_zone)
  

  tags = {
    Environment = module.label.id
    Description = "Basic EKS Cluster"
    Created_By  = "Terraform"
    Creator     = "Burak Koban"
    OSPlatform   = "Linux"
  }
}