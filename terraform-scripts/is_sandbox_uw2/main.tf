###### AWS Providers #####
provider "aws" {
  region  = "us-west-2"
  profile = var.default_profile
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

provider "aws" {
  alias   = "shared_service_ca1"
  region  = "ca-central-1"
  profile = "shared_service"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

provider "aws" {
  alias   = "shared_service_uw2"
  region  = "us-west-2"
  profile = "shared_service"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

provider "aws" {
  alias   = "bcaa_ts"
  region  = "us-west-2"
  profile = "bcaa_ts"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

provider "aws" {
  alias   = "ssm"
  region  = "ca-central-1"
  profile = "automation"
  shared_credentials_files = ["~/.aws/credentials"]

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  #skip_requesting_account_id  = true
}

data "aws_caller_identity" "current" {}
data "aws_caller_identity" "ssm" {provider = aws.ssm }
data "aws_region" "current" {}

locals {
  name            = replace(basename(path.cwd), "_", "-")
  default_region  = data.aws_region.current.name
  azs             = ["${local.default_region}a", "${local.default_region}b", "${local.default_region}d"]
  ssm_base_path   = "devops/aws/${data.aws_caller_identity.current.account_id}/${local.default_region}"

  tags = {
    Environment = local.name
    Created_By  = "Terraform"
    Owner       = "Ryan Degner"
    Team        = "IS"
    Creator     = "Burak Koban"
  }
}

### VPC and Subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.2.0"

  name = "${local.name}-vpc1"
  cidr = var.vpc_cidr

  azs              = local.azs
  private_subnets  = var.private_subnets
  # intra_subnets    = var.intra_subnets
  public_subnets   = var.public_subnets
  create_igw       = true
  
  create_database_subnet_group  = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC Flow Logs 
  enable_flow_log                   = true
  flow_log_destination_type         = "s3"
  flow_log_destination_arn          = "${data.aws_ssm_parameter.vpc_flow_log_arn.value}/"
  flow_log_max_aggregation_interval = 60

  tags = merge({
    GithubRepo  = "terraform-aws-vpc"
    GithubOrg   = "terraform-aws-modules"
  }, local.tags)
}

### VPC Endpoints
module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.2.0"

  vpc_id                     = module.vpc.vpc_id
  create_security_group      = true
  security_group_name_prefix = "${local.name}-vpc-endpoints-sg"
  security_group_description = "VPC endpoint security group"

  endpoints = {
    s3 = {
      # interface endpoint
      service             = "s3"
      tags                = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "ecs-vpc-endpoint" }
    },
    ecs_telemetry = {
      create              = false
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      tags                = { Name = "ecr-api-vpc-endpoint" }
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
      tags                = { Name = "ecr-dkr-vpc-endpoint" }
    },
    rds = {
      service             = "rds"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [aws_security_group.rds.id]
      tags                = { Name = "rds-vpc-endpoint" }
    },
  }

  tags = merge({
    GithubRepo  = "terraform-aws-vpc"
    GithubOrg   = "terraform-aws-modules"
  }, local.tags)
}

### Supporting Resources
data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

resource "aws_security_group" "rds" {
  name_prefix = "${local.name}-rds"
  description = "Allow PostgreSQL inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = local.tags
}

### Transit Gateway and routing
data "aws_ec2_transit_gateway" "this" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "owner-id"
    values = ["511305002140"]
  }  
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = module.vpc.private_subnets
  transit_gateway_id = data.aws_ec2_transit_gateway.this.id
  vpc_id             = module.vpc.vpc_id

  tags = merge({
    Name  = "tgw-${local.name}---sharedservices-ca1"
  }, local.tags)
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "tgw-acceptor" {
  provider = aws.shared_service_uw2
  
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_default_route_table_association = false 
  transit_gateway_default_route_table_propagation = false

  tags = merge({
    Name  = "tgw-sharedservices-ca1---${local.name}"
    Side = "Accepter"
  }, local.tags)
}

# resource "aws_route" "intra_tgw" {
#   count                  = length(module.vpc.intra_route_table_ids) > 0 ? length(module.vpc.intra_route_table_ids) : 0 
#   route_table_id         = element(module.vpc.intra_route_table_ids[*], count.index)
#   destination_cidr_block = "0.0.0.0/0"
#  gateway_id             = data.aws_ec2_transit_gateway.this.id

#   depends_on = [
#     aws_ec2_transit_gateway_vpc_attachment_accepter.tgw-acceptor
#   ]

#   timeouts {
#     create = "5m"
#   }
# }

resource "aws_route" "private_tgw" {
  count                  = length(module.vpc.private_route_table_ids) > 0 ? length(module.vpc.private_route_table_ids) : 0
  route_table_id         = element(module.vpc.private_route_table_ids[*], count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_ec2_transit_gateway.this.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw-acceptor
  ]

  timeouts {
    create = "5m"
  }
}

### Transit gateway route tables 
resource "aws_ec2_transit_gateway_route_table_association" "vpc_interconnection" {
  count = var.vpc_interconnection && !var.tgw_inspect_all ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw-acceptor
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_interconnection" {
  count = var.vpc_interconnection && !var.tgw_inspect_all ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw-acceptor
  ]

}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_igw" {
   count = var.tgw_igw && !var.tgw_inspect_all ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_igw_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw-acceptor
  ]

}

### TGW across region
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_across_region" {
  count = var.tgw_across_region ? 1 : 0
  provider = aws.shared_service_uw2

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_across_region_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw-acceptor
  ]
}

resource "aws_ec2_transit_gateway_route" "tgw_across_region" {
  count = var.tgw_across_region ? 1 : 0
  provider = aws.shared_service_uw2

  destination_cidr_block         = var.vpc_cidr
  transit_gateway_attachment_id  = data.aws_ssm_parameter.tgw_attachment_peering_uw2.value
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_uw2.value
}

### Route53 dns resolver
resource "aws_route53_resolver_rule_association" "resolver_rule_bcaa_bc_ca" {
  resolver_rule_id = data.aws_ssm_parameter.resolver_rule_bcaa_bc_ca.value
  vpc_id           = module.vpc.vpc_id
}

# resource "aws_route53_resolver_rule_association" "resolver_rule_dnadev_bcaa_bc_ca" {
#   resolver_rule_id = data.aws_ssm_parameter.resolver_rule_dnadev_bcaa_bc_ca.value
#   vpc_id           = module.vpc.vpc_id
# }

# resource "aws_route53_resolver_rule_association" "resolver_rule_dnapre_bcaa_bc_ca" {
#   resolver_rule_id = data.aws_ssm_parameter.resolver_rule_dnapre_bcaa_bc_ca.value
#   vpc_id           = module.vpc.vpc_id
# }

# resource "aws_route53_resolver_rule_association" "resolver_rule_dnasit_bcaa_bc_ca" {
#   resolver_rule_id = data.aws_ssm_parameter.resolver_rule_dnasit_bcaa_bc_ca.value
#   vpc_id           = module.vpc.vpc_id
# }

# resource "aws_route53_resolver_rule_association" "resolver_rule_dnatest_bcaa_bc_ca" {
#   resolver_rule_id = data.aws_ssm_parameter.resolver_rule_dnatest_bcaa_bc_ca.value
#   vpc_id           = module.vpc.vpc_id
# }

# resource "aws_route53_resolver_rule_association" "resolver_rule_dnatrn_bcaa_bc_ca" {
#   resolver_rule_id = data.aws_ssm_parameter.resolver_rule_dnatrn_bcaa_bc_ca.value
#   vpc_id           = module.vpc.vpc_id
# }

# resource "aws_route53_resolver_rule_association" "resolver_rule_dna_bcaa_bc_ca" {
#  resolver_rule_id = data.aws_ssm_parameter.resolver_rule_dna_bcaa_bc_ca.value
#  vpc_id           = module.vpc.vpc_id
# }

### Route53 dns delegation zone
resource "aws_route53_zone" "this" {
  count         = var.zone_enabled ? 1 : 0
  name          = var.domain_name
  force_destroy = true
  tags          = local.tags
}

resource "aws_route53_record" "ns" {
  count    = var.zone_enabled ? 1 : 0
  provider = aws.bcaa_ts

  zone_id = data.aws_ssm_parameter.zone_id_bcaa_bc_ca.value
  name    = var.domain_name
  type    = "NS"
  ttl     = "60"

  records = [
    aws_route53_zone.this[0].name_servers[0],
    aws_route53_zone.this[0].name_servers[1],
    aws_route53_zone.this[0].name_servers[2],
    aws_route53_zone.this[0].name_servers[3],
  ]
}

### ACM certificate
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 5.0"

  domain_name = var.domain_name
  zone_id     = var.zone_enabled ? join("", aws_route53_zone.this.*.zone_id) : var.zone_id

  subject_alternative_names = [
    "*.${var.domain_name}",
  ]

  validation_method = "DNS"
  wait_for_validation = true

  tags = merge({
    Name = var.domain_name
  }, local.tags)

}

### KMS key
locals {
  kms_keys = {
    "ebs" = {
      name                    = "ebs"
      description             = "KMS key for ebs"
      alias                   = "alias/bcaa/ebs"
      deletion_window_in_days = 10
      enable_key_rotation     = true
    }
    "rds" = {
      name                    = "rds"
      description             = "KMS key for rds"
      alias                   = "alias/bcaa/rds"
      deletion_window_in_days = 10
      enable_key_rotation     = true
    }
    "secret" = {
      name                    = "rds"
      description             = "KMS key for secret"
      alias                   = "alias/bcaa/secret"
      deletion_window_in_days = 10
      enable_key_rotation     = true
    }
    "s3" = {
      name                    = "s3"
      description             = "KMS key for s3"
      alias                   = "alias/bcaa/s3"
      deletion_window_in_days = 10
      enable_key_rotation     = true
    }
  }
}

module kms {
  source = "git::git@bitbucket.org:bcaacai/terraform-aws-kms-key?ref=v0.1.0"

  for_each = local.kms_keys

  namespace               = "sandbox"
  stage                   = "sandbox-uw2"
  name                    = try(each.value.name, each.key)
  description             = try(each.value.description, null)
  deletion_window_in_days = try(each.value.deletion_window_in_days, 10)
  enable_key_rotation     = try(each.value.enable_key_rotation , true)
  alias                   = try(each.value.alias , null)
  
  tags = local.tags
}

### Data protection and security
resource "aws_ebs_encryption_by_default" "ebs" {
  enabled = true
}

resource "aws_ebs_default_kms_key" "ebs" {
  key_arn = { for k, name in module.kms : k => name.key_arn }["ebs"]
}


### Base keypair
module "key_pair_ec2" {
  source = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0.2"

  key_name           = "${local.name}-ec2-keypair"
  create_private_key = true

  tags = local.tags
}

module "ssm_tls_ssh_key_pair_ec2" {
  source    = "git::git@bitbucket.org:bcaacai/terraform-aws-ssm-tls-ssh-key-pair.git?ref=tags/v0.1.0"
  providers = {aws = aws.ssm}

  namespace  = "sandbox"
  stage      = "sandbox-uw2"
  name       = "ec2"
  attributes = ["ssh"]

  kms_key_id           = data.aws_kms_key.ssm_kms.id
  ssm_path_prefix      = "${local.ssm_base_path}/ec2"
  ssh_key_algorithm    = "RSA"
  ssh_private_key_name = "${local.name}-ec2-keypair.pem"
  ssh_public_key_name  = "${local.name}-ec2-keypair.pub"
  private_rsa_key      = module.key_pair_ec2.private_key_pem
  public_rsa_key       = module.key_pair_ec2.public_key_pem

  tags = local.tags
}

data "aws_kms_key" "ssm_kms" {
  provider = aws.ssm
  key_id = "alias/bcaa/ssm"
}

### IAM password policy
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 24
  require_symbols                = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  allow_users_to_change_password = true 
  max_password_age               = 90
  password_reuse_prevention      = 24
  hard_expiry                    = false
}
