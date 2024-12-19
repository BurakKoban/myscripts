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
  vpc_id                  = data.aws_ssm_parameter.vpc_id.value
  private_subnets         = jsondecode(data.aws_ssm_parameter.private_subnets.value)
  default_region          = data.aws_region.current.name
  key_pair_name           = data.aws_ssm_parameter.key_pair_name.value
  count_availability_zone = (length(data.aws_availability_zones.available.names) <= 3) ? length(data.aws_availability_zones.available.zone_ids) : 3
  azs                     = slice(data.aws_availability_zones.available.names, 0, local.count_availability_zone)
  ssm_base_path           = "devops/aws/${data.aws_caller_identity.current.account_id}/${local.default_region}"

  tags = {
    Environment = module.label.id
    Department  = "Digital BCAA.com"
    Description = "Bcaa.com Test Server"
    Created_By  = "Terraform"
    TicketNumber = "SCTASK0136456"
    Owner       = "James Song"
    Creator     = "Burak Koban"
  }

  ec2_parameters = {

    # Bcaa web Test Server
    "w_test_as6" = {
      instance_name          = "${module.label.id}-as6"
      security_group_name    = "${module.label.id}-as-sg"
      ami                    = data.aws_ami.w_test_as2_image.id
      instance_type          = var.ec2_type
      key_name               = local.key_pair_name
      subnet_id              = element(local.private_subnets, 0)
      vpc_security_group_ids = [{ for k, name in module.w_test_as_sg : k => name.security_group_id }["w_test_as"]]
      kms_key_id             = var.kms_key_id
      volume_type            = "gp3"
      root_volume_size       = 100
      second_volume_size     = 100
      root_volume_name       = "${module.label.id}-as6 C: driver"
      second_volume_name     = "${module.label.id}-as6 D: driver"

      tags = {
        OSPlatform = "Windows2022"
        OSUse      = "Server"
        IMDSv2     = "Required"
        PatchSys   = "SSM"
        PatchGroup = "TST"
        PatchTime  = "See SSM Maintenance Window"
        Backups    = "Yes SCTASK0125479"
      }
    }
  }

    
  sg_parameters = {

    # Bcaa web Test Server
    "w_test_as" = {
      security_group_name = "${module.label.id}-as-sg"
      ingress_with_cidr_blocks = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = -1
          description = "Allow inbound traffic"
          cidr_blocks = "10.0.0.0/8"
        },
        {
          from_port   = 0
          to_port     = 0
          protocol    = -1
          description = "Allow inbound traffic"
          cidr_blocks = "192.168.78.0/24"
        },
      ]
      egress_with_cidr_blocks = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = -1
          description = "Allow outbound traffic"
          cidr_blocks = "0.0.0.0/0"
        },
      ]
    }
  }
}

# Bcaa web test instances
module "w_test_as" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.6.0"

  for_each = local.ec2_parameters

  name                   = try(each.value.instance_name, null)
  key_name               = try(each.value.key_name, null)
  ignore_ami_changes     = true
  ami                    = try(each.value.ami, data.aws_ami.win2022server.id)
  instance_type          = try(each.value.instance_type, "t2.large")
  cpu_credits            = "unlimited"
  subnet_id              = try(each.value.subnet_id, element(local.private_subnets, 0))
  vpc_security_group_ids = try(each.value.vpc_security_group_ids, [])

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMDirectoryServiceAccess = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
    AmazonSSMManagedInstanceCore    = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  enable_volume_tags = false
  root_block_device = [{
    volume_type = "gp3"
    volume_size = try(each.value.root_volume_size, 100)
    encrypted   = true
    kms_key_id  = try(each.value.kms_key_id, null)

    tags = merge({
      Name = try(each.value.root_volume_name, null)
    }, try(each.value.tags, {}), local.tags)
  }]

  ebs_block_device = [{
    device_name = "xvdb"
    volume_type = "gp3"
    volume_size = try(each.value.second_volume_size, 100)
    encrypted   = true
    kms_key_id  = try(each.value.kms_key_id, null)

    tags = merge({
      Name = try(each.value.second_volume_name, null)
    }, try(each.value.tags, {}), local.tags)
  }]

  tags = merge({
    GithubRepo = "terraform-aws-ec2-instance"
    GithubOrg  = "terraform-aws-modules"
  }, try(each.value.tags, {}), local.tags)
}


# Security groups for Bcaa web test instances 
module "w_test_as_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.0"

  for_each = local.sg_parameters

  name        = try(each.value.security_group_name, null)
  description = "Allow inbound traffic"
  vpc_id      = local.vpc_id

  ingress_with_cidr_blocks = try(each.value.ingress_with_cidr_blocks, [])
  egress_with_cidr_blocks  = try(each.value.egress_with_cidr_blocks, [])

  tags = merge({
    GithubRepo = "terraform-aws-security-group"
    GithubOrg  = "terraform-aws-modules"
  }, local.tags)
}