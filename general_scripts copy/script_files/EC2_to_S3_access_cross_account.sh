# The account with S3 access

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::DOC-EXAMPLE-BUCKET/*",
                "arn:aws:s3:::DOC-EXAMPLE-BUCKET"
            ]
        }
    ]
}

# The account with EC2 access

{
	"Version": "2012-10-17",
	"Statement": [{
		"Effect": "Allow",
		"Action": "sts:AssumeRole",
		"Resource": "arn:aws:iam::111111111111:role/ROLENAME"
	}]
}

# To find the ~/.aws folder

ls -l ~/.aws

#  If you find the ~/.aws folder, then proceed to the next step. If the directory doesn't have a ~/.aws folder

mkdir ~/.aws/

# Within the ~/.aws folder, use a text editor to create a file. Name the file config.

# In the file, enter the following text. Replace enterprofilename with the name of the role that you attached to the instance. Then, replace arn:aws:iam::111111111111:role/ROLENAME with the ARN of the role that you created in Account B.

[profile enterprofilename]
role_arn = arn:aws:iam::111111111111:role/ROLENAME

credential_source = Ec2InstanceMetadata

# Save and close the file

# To Verify that the instance profile can assume the role

aws sts get-caller-identity --profile profilename

# To test the setup

aws s3 ls s3://DOC-EXAMPLE-BUCKET --profile profilename