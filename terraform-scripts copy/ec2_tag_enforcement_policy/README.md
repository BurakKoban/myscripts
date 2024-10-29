AWS SCP Module for Terraform

Included statements are:

- Deny creation of an EC2 instance without mandatory tags
- Deny removing the mandatory tags

The mandatory tags are:

- Name
- Creator
- Department
- Description
- TicketNumber
- Environment

## Prerequisite
### IaC develeop environment
  * [VS Code integration with WSL](https://bitbucket.org/bcaacai/aws-iac-bcaa/src/main/tf-bcaa/core-infrastructure/multi-accounts-infra/multi-scp-policies/ec2-mandatorytag-scp/README.md)
  * [VS Code integration with Amazon EC2](https://bitbucket.org/bcaacai/aws-iac-bcaa/src/main/tf-bcaa/core-infrastructure/multi-accounts-infra/multi-scp-policies/ec2-mandatorytag-scp/main.tf)
  * [AWS SSO multiple profiles work with Terraform multiple providers](https://bitbucket.org/bcaacai/aws-iac-bcaa/src/main/tf-bcaa/core-infrastructure/multi-accounts-infra/multi-scp-policies/ec2-mandatorytag-scp/versions.tf)

  | Provider | Profile Name | AD Group| SSO Role | Account ID | Region |
  |----------|--------------|----------|---------|------------|--------|
  | <a name="default"></a> [default](#default) | aws_master | AWS-SSO-AWSMaster-AdminAccess | AdministratorAccess | 337558554106 | us-west-2 |
  | <a name="S3 state backend"></a> [S3 state backend](#S3 state backend) | automation_tf | AWS-SSO-Automation-Terraform | Automation-Terraform | 155754364360 | us-west-2 |

  ### Outputs

  | Name | description | type |
  |------|-------------|------|
  | <a name="vpc_id"></a> [scp\_policy\_document] | The policy document of SCP | string |
  | <a name="vpc_id"></a> [the\_name\_of\_the\_scp] | The Name of the SCP | string |
  | <a name="vpc_id"></a> [root\_ou] | The Root OU | string |
  | <a name="vpc_id"></a> [sub\_ous] | The ARN, ID and Name of the Child OUs | string |