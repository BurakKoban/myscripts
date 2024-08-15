### SSM Parameters Output
locals {

  parameters = {
    #########
    # String
    #########
    # VPC
    "vpc_id" = {
      name = "/${local.ssm_base_path}/vpc/vpc_id"
      value = module.vpc.vpc_id
    }
    "vpc_cidr_block" = {
      name = "/${local.ssm_base_path}/vpc/vpc_cidr_block"
      value = module.vpc.vpc_cidr_block
    }
    "public_internet_gateway_route_id" = {
      name = "/${local.ssm_base_path}/vpc/public_internet_gateway_route_id"
      value = module.vpc.public_internet_gateway_route_id
    }
    "igw_id" = {
      name = "/${local.ssm_base_path}/vpc/igw_id"
      value = module.vpc.igw_id
    }
    "vpc_flow_log_id" = {
      name = "/${local.ssm_base_path}/vpc/vpc_flow_log_id"
      value = module.vpc.vpc_flow_log_id
    }

    # Route53
    "route53_zone_id" = {
      name = "/${local.ssm_base_path}/route53/route53_zone_id"
      value = try(aws_route53_zone.this[0].id)
    }

    # ACM
    "acm_certificate_arn" = {
      name = "/${local.ssm_base_path}/acm/acm_certificate_arn"
      value = module.acm.acm_certificate_arn
    }

    # KMS
    "ebs_key_arn" = {
      name = "/${local.ssm_base_path}/kms/ebs_key_arn"
      value = { for k, name in module.kms : k => name.key_arn }["ebs"]
    }
    "ebs_key_id" = {
      name = "/${local.ssm_base_path}/kms/ebs_key_id"
      value = { for k, name in module.kms : k => name.key_id }["ebs"]
    }
    "rds_key_arn" = {
      name = "/${local.ssm_base_path}/kms/rds_key_arn"
      value = { for k, name in module.kms : k => name.key_arn }["rds"]
    }
    "rds_key_id" = {
      name = "/${local.ssm_base_path}/kms/rds_key_id"
      value = { for k, name in module.kms : k => name.key_id }["rds"]
    }
    "secret_key_arn" = {
      name = "/${local.ssm_base_path}/kms/secret_key_arn"
      value = { for k, name in module.kms : k => name.key_arn }["secret"]
    }
    "secret_key_id" = {
      name = "/${local.ssm_base_path}/kms/secret_key_id"
      value = { for k, name in module.kms : k => name.key_id }["secret"]
    }
    "s3_key_arn" = {
      name = "/${local.ssm_base_path}/kms/s3_key_arn"
      value = { for k, name in module.kms : k => name.key_arn }["s3"]
    }
    "s3_key_id" = {
      name = "/${local.ssm_base_path}/kms/s3_key_id"
      value = { for k, name in module.kms : k => name.key_id }["s3"]
    }

    # EC2
    "key_pair_id" = {
      name = "/${local.ssm_base_path}/ec2/key_pair_id"
      value = module.key_pair_ec2.key_pair_id
    }
    "key_pair_arn" = {
      name = "/${local.ssm_base_path}/ec2/key_pair_arn"
      value = module.key_pair_ec2.key_pair_arn
    }
    "key_pair_name" = {
      name = "/${local.ssm_base_path}/ec2/key_pair_name"
      value = module.key_pair_ec2.key_pair_name
    }

    ###############
    # SecureString
    ###############
    "secure_encrypted" = {
      name         = "/${local.ssm_base_path}/vpc/test_SecureString"
      secure_type = true
      value       = "secret123123!!!"
      key_id      = data.aws_kms_key.ssm_kms.id
    }

    #############
    # StringList
    #############
    "private_subnets" = {
      name   = "/${local.ssm_base_path}/vpc/private_subnets"
      type   = "StringList"
      values = module.vpc.private_subnets
    }
    "public_subnets" = {
      name   = "/${local.ssm_base_path}/vpc/public_subnets"
      type   = "StringList"
      values = module.vpc.public_subnets
    }
    "intra_subnets" = {
      name   = "/${local.ssm_base_path}/vpc/intra_subnets"
      type   = "StringList"
      values = module.vpc.intra_subnets
    }
    "public_route_table_ids" = {
      name   = "/${local.ssm_base_path}/vpc/public_route_table_ids"
      type   = "StringList"
      values = module.vpc.public_route_table_ids
    }
    "private_route_table_ids" = {
      name   = "/${local.ssm_base_path}/vpc/private_route_table_ids"
      type   = "StringList"
      values = module.vpc.private_route_table_ids
    }
    "intra_route_table_ids" = {
      name   = "/${local.ssm_base_path}/vpc/intra_route_table_ids"
      type   = "StringList"
      values = module.vpc.intra_route_table_ids
    }
  }
}

module ssm {
  source  = "terraform-aws-modules/ssm-parameter/aws"
  version = "~> 1.1.0"

  providers = {aws = aws.ssm}

  for_each = local.parameters

  name            = try(each.value.name, each.key)
  value           = try(each.value.value, null)
  values          = try(each.value.values, [])
  type            = try(each.value.type, null)
  secure_type     = try(each.value.secure_type, null)
  description     = try(each.value.description, null)
  tier            = try(each.value.tier, null)
  key_id          = try(each.value.key_id, null)
  allowed_pattern = try(each.value.allowed_pattern, null)
  data_type       = try(each.value.data_type, null)

  tags = local.tags
}


### SSM Parameters Iutput
// TGW route table Inbound-VPN-IGW
data "aws_ssm_parameter" "zone_id_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/474372112003/global/route53/public_zone_id/bcaa_bc_ca"
}

data "aws_ssm_parameter" "tgw_igw_route_table_ca1" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/vpc/tgw/tgw_igw_route_table_ca1"
}

// TGW route table VPC-Attachment-ALL
data "aws_ssm_parameter" "tgw_interconnection_route_table_ca1" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/vpc/tgw/tgw_interconnection_route_table_ca1"
}

// TGW peering attachment id
data "aws_ssm_parameter" "tgw_attachment_peering_ca1" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/vpc/tgw/tgw_attachment_peering_ca1"
}

// TGW route table Inbound-TGW-UW2
data "aws_ssm_parameter" "tgw_across_region_route_table_ca1" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/vpc/tgw/tgw_across_region_route_table_ca1"
}

// TGW route table VPC-Attachment-ALL
data "aws_ssm_parameter" "tgw_interconnection_route_table_uw2" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/us-west-2/vpc/tgw/tgw_interconnection_route_table_uw2"
}

// TGW peering attachment id
data "aws_ssm_parameter" "tgw_attachment_peering_uw2" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/us-west-2/vpc/tgw/tgw_attachment_peering_uw2"
}

data "aws_ssm_parameter" "resolver_rule_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_bcaa_bc_ca"
}

data "aws_ssm_parameter" "resolver_rule_dnadev_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_dnadev_bcaa_bc_ca"
}

data "aws_ssm_parameter" "resolver_rule_dnapre_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_dnapre_bcaa_bc_ca"
}

data "aws_ssm_parameter" "resolver_rule_dnasit_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_dnasit_bcaa_bc_ca"
}

data "aws_ssm_parameter" "resolver_rule_dnatest_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_dnatest_bcaa_bc_ca"
}

data "aws_ssm_parameter" "resolver_rule_dnatrn_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_dnatrn_bcaa_bc_ca"
}

data "aws_ssm_parameter" "resolver_rule_dna_bcaa_bc_ca" {
  provider = aws.ssm
  name     = "/devops/aws/511305002140/ca-central-1/route53/resolver_rules/resolver_rule_dna_bcaa_bc_ca"
}

data "aws_ssm_parameter" "vpc_flow_log_arn" {
  provider = aws.ssm
  name     = "/devops/aws/538275038169/us-west-2/s3/vpc_flow_log_arn"
}