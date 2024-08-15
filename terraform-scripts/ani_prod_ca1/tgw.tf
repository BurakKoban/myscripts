####################################
### If the default region is CA1 ###
####################################

### Transit gateway route tables 
resource "aws_ec2_transit_gateway_route_table_association" "vpc_interconnection_ca1" {
  count = var.vpc_interconnection && !var.tgw_inspect_all && local.default_region == "ca-central-1" ? 1 : 0
  provider = aws.shared_service_ca1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_ca1.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_ca1[0]
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_interconnection_ca1" {
  count = var.vpc_interconnection && !var.tgw_inspect_all && local.default_region == "ca-central-1" ? 1 : 0
  provider = aws.shared_service_ca1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_ca1.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_ca1[0]
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_igw_ca1" {
  count = var.tgw_igw && !var.tgw_inspect_all && local.default_region == "ca-central-1" ? 1 : 0
  provider = aws.shared_service_ca1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_igw_route_table_ca1.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_ca1[0]
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_inspect_all_ca1" {
  count = var.tgw_inspect_all && local.default_region == "ca-central-1" ? 1 : 0
  provider = aws.shared_service_ca1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_inspect_all_route_table_ca1.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_ca1[0]
  ]
}

### TGW across region
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_across_region_ca1" {
  count = var.tgw_across_region && local.default_region == "ca-central-1" ? 1 : 0
  provider = aws.shared_service_ca1

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_across_region_route_table_ca1.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_ca1[0]
  ]
}

resource "aws_ec2_transit_gateway_route" "tgw_across_region_ca1" {
  count = var.tgw_across_region && local.default_region == "ca-central-1" ? 1 : 0
  provider = aws.shared_service_uw2

  destination_cidr_block         = var.vpc_cidr
  transit_gateway_attachment_id  = data.aws_ssm_parameter.tgw_attachment_peering_uw2.value
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_uw2.value
}

####################################
### if the default region is UW2 ###
####################################

### Transit gateway route tables 
resource "aws_ec2_transit_gateway_route_table_association" "vpc_interconnection_uw2" {
  count = var.vpc_interconnection && !var.tgw_inspect_all && local.default_region == "us-west-2" ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_uw2[0]
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_interconnection_uw2" {
  count = var.vpc_interconnection && !var.tgw_inspect_all && local.default_region == "us-west-2" ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_uw2[0]
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_igw_uw2" {
  count = var.tgw_igw && !var.tgw_inspect_all && local.default_region == "us-west-2" ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_igw_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_uw2[0]
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_inspect_all_uw2" {
  count = var.tgw_inspect_all && local.default_region == "us-west-2" ? 1 : 0
  provider = aws.shared_service_uw2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_inspect_all_route_table_uw2.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_uw2[0]
  ]
}

### TGW across region
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_across_region_uw2" {
  count = var.tgw_across_region && local.default_region == "us-west-2" ? 1 : 0
  provider = aws.shared_service_uw2

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_across_region_route_table_ca1.value

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.tgw_acceptor_uw2[0]
  ]
}

resource "aws_ec2_transit_gateway_route" "tgw_across_region_uw2" {
  count = var.tgw_across_region && local.default_region == "us-west-2" ? 1 : 0
  provider = aws.shared_service_ca1

  destination_cidr_block         = var.vpc_cidr
  transit_gateway_attachment_id  = data.aws_ssm_parameter.tgw_attachment_peering_ca1.value
  transit_gateway_route_table_id = data.aws_ssm_parameter.tgw_interconnection_route_table_ca1.value
}