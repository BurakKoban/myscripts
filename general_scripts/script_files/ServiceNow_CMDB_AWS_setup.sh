# ServiceNow CMDB AWS Setup ( https://www.servicenow.com/community/cmdb-articles/service-graph-connector-for-aws-introduction/ta-p/2300757 )

# 1- Enable AWS Config Recorder

# 2- Create AWS Config Aggregator
#    a-  "ServiceNowConfigurationAggregator" has been created.
#    b-  "AWSConfigRoleForOrganizationsServiceNow" IAM role has been created and attached to the Aggregator "ServiceNowConfigurationAggregator". 
#        Also "ServiceNow_ConfigAggregator" IAM policy has been created and attached to the role "AWSConfigRoleForOrganizationsServiceNow" along with AWs managed policy "AWSConfigRoleForOrganizations"

# 3- AWS Systems Manager Inventory and Service Graph connector for AWS Integration
#    a- By default, AWS Systems Manager doesn’t have permission to perform actions on your instances. 
#       So, you will need to grant access by attaching an AWS IAM instance profile role (AmazonSSMForInstancesRole) to an EC2 instance.
#    b- As part of the Service Graph connector for AWS, it imports the software installed in the instances and populates the CI information.
#    c- The following components should be available in all of the accounts for the Systems Manager integration to be successful:
#       Systems Manager Agent (SSM Agent) installed in EC2 instances.
#       AmazonSSMManagedInstanceCore policy attached as instance profile in EC2 instances.
#       Systems Manager Inventory setup configured in each region.
#    d- AWS Systems Manager Inventory Setup
#       Created a role and attach it to the EC2 instances with these policies 1- "AmazonSSMManagedInstanceCore" and 2- "AmazonEC2RoleforSSM"
#    e- Setup AWS Systems Manager Inventory
#       1- AWS provides an automation script which is available as part of the AWS Systems Manager Automation which will setup the AWS Systems Manager inventory in an account. 
#       You can navigate to AWS Systems Manager > Automation > Execute
#       2- From this page, you need to navigate inside the 'AWS-SetupInventory', click on "Execute Automation". 
#       Once you are in this page, you can execute the document and it will setup SSM inventory in the account region. 


# IAM User

# 1- Creating an IAM user for ServiceNow access. "bcaa-servicenow-cmdb-user" has been created.
#    a- "bcaa-servicenow-cmdb-bucket" S3 bucket has been created for AWS SSM EC2 inventory data to be stored.
# 2- Creating a role to be used by ServiceNow "ServicenowOrganizationAccountAccessRole" with a policy "ServicenowOrganizationAccountAccessPolicy" :

{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": [
            "organizations:DescribeOrganization",
            "organizations:ListAccounts",
            "config:ListDiscoveredResources",
            "config:SelectAggregateResourceConfig",
            "config:BatchGetAggregateResourceConfig",
            "config:SelectResourceConfig",
            "config:BatchGetResourceConfig",
            "ec2:DescribeRegions",
            "ec2:DescribeImages",
            "ec2:DescribeInstances",
            "ec2:DescribeInstanceTypes",
            "ssm:DescribeInstanceInformation",
            "ssm:ListInventoryEntries",
            "ssm:GetInventory",
            "ssm:SendCommand",
            "s3:GetObject",
            "s3:DeleteObject",
            "tag:GetResources",
            "iam:CreateAccessKey",
            "iam:DeleteAccessKey"
        ],
        "Resource": "*",
        "Effect": "Allow",
        "Sid": "ServiceNowUserReadOnlyAccess"
     },
     {
       "Action": [
           "ssm:SendCommand"
        ],
       "Resource": [
          "arn:aws:ec2:*:*:instance/*",
          "arn:aws:ssm:*:*:document/SG-AWS-RunShellScript",
          "arn:aws:ssm:*:*:document/SG-AWS-RunPowerShellScript"
       ],
       "Effect": "Allow",
       "Sid": "SendCommandAccess"
     },
     {
       "Action": [
          "s3:GetObject",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:DeleteObject"
       ],
       "Resource": [
         "arn:aws:s3:::myBucket/*"
       ],
       "Effect": "Allow",
       "Sid": "S3BucketAccess"
     }
   ]
}



