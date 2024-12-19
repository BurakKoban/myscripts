#module "label" {
#  source      = "git::git@bitbucket.org:bcaacai/terraform-null-label?ref=tags/v0.1.1"
#  namespace   = var.namespace
#  environment = var.environment
#  stage       = var.stage
#  name        = var.name
#  attributes  = var.attributes
#  delimiter   = var.delimiter
#  label_order = ["namespace", "stage", "environment", "name", "attributes"]
#}
#
#locals {
#  name                    = replace(basename(path.cwd), "_", "-")
#  
#  default_region          = data.aws_region.current.name
#  cluster_name            = module.label.id
#  cluster_version         = var.cluster_version
#  profile                 = var.default_profile
#  key_pair_name           = data.aws_ssm_parameter.key_pair_name.value
#  count_availability_zone = (length(data.aws_availability_zones.available.names) <= 3) ? length(data.aws_availability_zones.available.zone_ids) : 3
#  azs                     = slice(data.aws_availability_zones.available.names, 0, local.count_availability_zone)
#  ssm_base_path           = "devops/aws/${data.aws_caller_identity.current.account_id}/${local.default_region}"
#
#  
#  vpc_id                  = data.aws_ssm_parameter.vpc_id.value
#  private_subnets         = jsondecode(data.aws_ssm_parameter.private_subnets.value)
#  public_subnets          = jsondecode(data.aws_ssm_parameter.public_subnets.value)
#  cidr_blocks             = split(",", data.aws_ssm_parameter.vpc_cidr_block.value)
#
#  tags = {
#    Environment = module.label.id
#    Department  = "IS"
#    Description = "Burak Test EKS Cluster"
#    Created_By  = "Terraform"
#    TicketNumber = "SCTASK0000"
#    Owner       = "Ryan Degner"
#    Creator     = "Burak Koban"
#    Backups      = "NO"
#    PatchSys     = "EKS"
#    OSPlatform   = "Linux"
#  }
#}