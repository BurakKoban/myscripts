# # AnI Prod Account(CA1) Configuration
Automate the management of fundamental infrastructure components within an account

## Available Features
### VPC
  * VPC settings
  * Subnets
  * IGW
  * Routing table
  * DHCP
  * VPC Flow Logs
  * VPC Endpoints (SG, policy)
### TGW 
  * VPC interconnections
  * VPC internet access
  * VPC across regions access
### DNS
  * Route 53 Subdomain
  * DNS zone delegation
  * Route 53 Resolver rules
### ACM
  * Wildcard certificate
  * DNS validation 
### KMS CMK
  * EBS KMS
  * RDS KMS
  * Secret KMS
  * S3 KMS
  * KMS policy
### EC2
  * Create Base EC2 key pair
  * Data protection and security
### SSM Parameter
  * Store EC2 base key pair
  * Input variables from central SSM Parameter store
  * Output parameters from central SSM Parameter store
### IAM password policy

## Prerequisite
### IaC develeop evironment
  * [VS Code integration with WSL](https://bitbucket.org/bcaacai/aws-iac-bcaa/src/master/tf-bcaa/core-infrastructure/single-account/account/ani_prod_ca1/README.md)
  * [VS Code integration with Amazon EC2](https://bitbucket.org/bcaacai/aws-iac-bcaa/src/master/tf-bcaa/core-infrastructure/single-account/account/ani_prod_ca1/main.tf)
  * [AWS SSO mutiple profiles work with Terraform mutiple providers](https://bitbucket.org/bcaacai/aws-iac-bcaa/src/master/tf-bcaa/core-infrastructure/single-account/account/ani_prod_ca1/versions.tf)

  | Provider | Profile Name | AD Group| SSO Role | Account ID | Region |
  |----------|--------------|----------|---------|------------|--------|
  | <a name="default"></a> [default](#default) | ani_prod | AWS-SSO-AnIProd-AdminAccess | AdministratorAccess | 583206303783 | ca-central-1 |
  | <a name="S3 state backend"></a> [S3 state backend](#S3 state backend) | automation_tf | AWS-SSO-Automation-Terraform | Automation-Terraform | 155754364360 | us-west-2 |
  | <a name="shared_service_ca1"></a> [shared\_service\_ca1](#shared\_service\_ca1) | shared\_service | AWS-SSO-SharedServices-AdminAccess | AdministratorAccess | 511305002140 | ca-central-1 |
  | <a name="shared_service_uw2"></a> [shared\_service\_uw2](#shared\_service\_uw2) | shared\_service | AWS-SSO-SharedServices-AdminAccess | AdministratorAccess | 511305002140 | us-west-2 |
  | <a name="bcaa_ts"></a> [bcaa\_ts](#bcaa\_ts) | bcaa\_ts | AWS-SSO-TS-AdminAccess | AdministratorAccess | 474372112003 | us-west-2 |
  | <a name="ssm"></a> [ssm](#ssm) | automation | AWS-SSO-Automation-AdminAccess | AdministratorAccess | 155754364360 | ca-central-1 |

### Orgnazation
  * Shared Route53 Resolver rules with Organization using AWS Resource Access Manager (RAM) in Shared service account
  * Shared TGW with Organization using AWS Resource Access Manager (RAM) in Shared service account

## Related Modules
- [terraform-aws-ssm-parameter](https://github.com/terraform-aws-modules/terraform-aws-ssm-parameter)
- [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)
- [terraform-aws-acm](https://github.com/terraform-aws-modules/terraform-aws-acm)
- [terraform-aws-kms](https://github.com/terraform-aws-modules/terraform-aws-kms)
- [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group)
- [terraform-aws-key-pair](https://github.com/terraform-aws-modules/terraform-aws-key-pair)
- [terraform-aws-ssm-tls-ssh-key-pair](https://bitbucket.org/bcaacai/terraform-aws-ssm-tls-ssh-key-pair/src/master)

## SSM Parameters
### Inputs

 | Name | description | type |
 |------|-------------|------|
 | <a name="zone_id_bcaa_bc_ca"></a> [zone\_id\_bcaa\_bc\_ca](#zone\_id\_bcaa\_bc\_ca) | Public Zone ID of bcaa.bc.ca hosted in BCAA TS account | string |
 | <a name="tgw_igw_route_table_ca1"></a> [tgw\_igw\_route\_table\_ca1](#tgw\_igw\_route\_table\_ca1) | The Transit gateway route table ID of `Inbound-VPN-IGW` in Shared service account CA region| string | 
 | <a name="tgw_interconnection_route_table_ca1"></a> [tgw\_interconnection\_route\_table\_ca1](#tgw\_interconnection\_route\_table\_ca1) | The Transit gateway route table ID of `VPC-Attachment-ALL` in Shared service account CA region| string | 
 | <a name="tgw_attachment_peering_ca1"></a> [tgw\_attachment\_peering\_ca1](#tgw\_attachment\_peering\_ca1) | The Transit gateway attachment ID of the peering connection in Shared service account CA region | string | 
 | <a name="tgw_across_region_route_table_ca1"></a> [tgw\_across\_region\_route\_table\_ca1](#tgw\_acros\_region\_route\_table\_ca1) | The Transit gateway route table ID of `Inbound-TGW-UW2` in Shared service account CA region| string |   
 | <a name="tgw_interconnection_route_table_uw2"></a> [tgw\_interconnection\_route\_table\_uw2](#tgw\_interconnection\_route\_table\_uw2) | The Transit gateway route table ID of `VPC-Attachment-ALL` in Shared service account Oregon region| string |   
 | <a name="tgw_attachment_peering_uw2"></a> [tgw\_attachment\_peering\_uw2](#tgw\_attachment\_peering\_uw2) | The Transit gateway attachment ID of the peering connection in Shared service account Oregon region | string |
 | <a name="resolver_rule_bcaa_bc_ca"></a> [resolver\_rule\_bcaa\_bc\_ca](#resolver\_rule\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="resolver_rule_dnadev_bcaa_bc_ca"></a> [resolver\_rule\_dnadev\_bcaa\_bc\_ca](#resolver\_rule\_dnadev\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_dnadev_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="resolver_rule_dnapre_bcaa_bc_ca"></a> [resolver\_rule\_dnapre\_bcaa\_bc\_ca](#resolver\_rule\_dnapre\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_dnapre_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="resolver_rule_dnasit_bcaa_bc_ca"></a> [resolver\_rule\_dnasit\_bcaa\_bc\_ca](#resolver\_rule\_dnasit\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_dnasit_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="resolver_rule_dnatest_bcaa_bc_ca"></a> [resolver\_rule\_dnatest\_bcaa\_bc\_ca](#resolver\_rule\_dnatest\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_dnatest_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="resolver_rule_dnatrn_bcaa_bc_ca"></a> [resolver\_rule\_dnatrn\_bcaa\_bc\_ca](#resolver\_rule\_dnatrn\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_dnatrn_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="resolver_rule_dna_bcaa_bc_ca"></a> [resolver\_rule\_dna\_bcaa\_bc\_ca](#resolver\_rule\_dna\_bcaa\_bc\_ca) | The Route53 Resolver rule ID of `outbound_rule_aws_dna_bcaa_bc_ca` in Shared service account CA region | string |
 | <a name="vpc_flow_log_arn"></a> [vpc\_flow\_log\_arn](#vpc\_flow\_log\_arn) | The ARN of the central S3 bucket for VPC flow logs | string |


### Outputs
 | Name | description | type |
 |------|-------------|------|
 | <a name="vpc_id"></a> [vpc\_id](#vpc\_id) | The ID of the VPC | string |
 | <a name="vpc_cidr_block"></a> [vpc\_cidr\_block](#vpc\_cidr\_block) | The CIDR block of the VPC | string |
 | <a name="public_internet_gateway_route_id"></a> [public\_internet\_gateway\_route\_id](#public\_internet\_gateway\_route\_id) | ID of the internet gateway route | string |
 | <a name="igw_id"></a> [igw\_id](#igw\_id) | The ID of the Internet Gateway | string |
 | <a name="vpc_flow_log_id"></a> [vpc\_flow\_log\_id](#vpc\_flow\_log\_id)| The ID of the VPC Flow Log | string |
 | <a name="route53_zone_id"></a> [route53\_zone\_id](#route53\_zone\_id) | The Zone Id of the domain `ani-prod.bcaa.bc.ca` | string |
 | <a name="acm_certificate_arn"></a> [acm\_certificate\_arn](#acm\_certificate\_arn) | The ARN of the certificate `*.ani-prod.bcaa.bc.ca` | string |
 | <a name="ebs_key_arn"></a> [ebs\_key\_arn](#ebs\_key\_arn) | The Amazon Resource Name (ARN) of the key alias `alias/bcaa/ebs` | string |
 | <a name="ebs_key_id"></a> [ebs\_key\_id](#ebs\_key\_id) | The globally unique identifier of the key alias `alias/bcaa/ebs` | string |
 | <a name="rds_key_arn"></a> [rds\_key\_arn](#rds\_key\_arn) | The Amazon Resource Name (ARN) of the key alias `alias/bcaa/rds` | string |
 | <a name="rds_key_id"></a> [rds\_key\_id](#rds\_key\_id) | The globally unique identifier of the key alias `alias/bcaa/rds` | string |
 | <a name="secret_key_arn"></a> [secret\_key\_arn](#secret\_key\_arn) | The Amazon Resource Name (ARN) of the key alias `alias/bcaa/secret` | string |
 | <a name="secret_key_id"></a> [secret\_key\_id](#secret\_key\_id) | The globally unique identifier of the key alias `alias/bcaa/secret` | string |
 | <a name="s3_key_arn"></a> [s3\_key\_arn](#s3\_key\_arn) | The Amazon Resource Name (ARN) of the key alias `alias/bcaa/s3` | string |
 | <a name="s3_key_id"></a> [s3\_key\_id](#rds\_key\_id) | The globally unique identifier of the key alias `alias/bcaa/s3` | string |
 | <a name="key_pair_id"></a> [key\_pair\_id](#key\_pair\_id) | The common key pair ID of `ani-prod-ca1-ec2-keypair` | string |
 | <a name="key_pair_arn"></a> [key\_pair\_arn](#key\_pair\_arn) | The key pair ARN of `ani-prod-ca1-ec2-keypair` | string |
 | <a name="key_pair_name"></a> [key\_pair\_name](#key\_pair\_name) | The key pair name | string |
 | <a name="ani-prod-ca1-ec2-keypair.pem"></a> [ani-prod-ca1-ec2-keypair.pem](#ani-prod-ca1-ec2-keypair.pem) | The private key pair pem file | securestring |
 | <a name="ani-prod-ca1-ec2-keypair.pub"></a> [ani-prod-ca1-ec2-keypair.pub](#ani-prod-ca1-ec2-keypair.pub) | The public key pair pub file | string |
 | <a name="private_subnets"></a> [private\_subnets](#private\_subnets) | List of IDs of private subnets| stringlist |
 | <a name="public_subnets"></a> [public\_subnets](#public\_subnets) | List of IDs of public subnets| stringlist |
 | <a name="intra_subnets"></a> [intra\_subnets](#intra\_subnets) | List of IDs of intra subnets| stringlist |
 | <a name="public_route_table_ids"></a> [public\_route\_table\_ids](#public\_route\_table\_ids) | List of IDs of public route tables| stringlist |
 | <a name="private_route_table_ids"></a> [private\_route\_table\_ids](#private\_route\_table\_ids) | List of IDs of private route tables| stringlist |
 | <a name="intra_route_table_ids"></a> [intra\_route\_table\_ids](#intra\_route\_table\_ids) | List of IDs of intra route tables| stringlist |
 | <a name="intra_route_table_ids"></a> [intra\_route\_table\_ids](#intra\_route\_table\_ids) | List of IDs of intra route tables| stringlist |