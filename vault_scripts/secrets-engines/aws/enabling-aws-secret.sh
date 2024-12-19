vault secrets enable -path=aws aws

vault write aws/config/root \
    access_key=ASIASIQ5O7XEKEHYJJLA \
    secret_key=YlfgJt4GXXCRax0QNFZd/rywjqUhV6qBMN0P7/ZJ \
    region=us-west-2
    
vault read aws/config/root

# Key                  Value
# ---                  -----
# access_key           ASIASIQ5O7XEKEHYJJLA
# iam_endpoint         n/a
# max_retries          -1
# region               us-west-2
# sts_endpoint         n/a
# username_template    {{ if (eq .Type "STS") }}{{ printf "vault-%s-%s"  (unix_time) (random 20) | truncate 32 }}{{ else }}{{ printf "vault-%s-%s-%s" (printf "%s-%s" (.DisplayName) (.PolicyName) | truncate 42) (unix_time) (random 20) | truncate 64 }}{{ end }}

vault write -f aws/config/rotate-root # To rotate the config access key between AWS and Vault

# To create a role for this aws path

vault write aws/roles/my-ec2-test-role credential_type=iam_user \
    policy_document=@./workspace/myscripts/policy.json


vault write aws/roles/vaultadvanced \
    policy_arn=arn:aws:iam::aws:policy/ReadOnlyAccess \
    credential_type=iam_user
# Success! Data written to: aws/roles/vaultadvanced

vault read aws/roles/vaultadvanced

# Key                         Value
# ---                         -----
# credential_type             iam_user
# default_sts_ttl             0s
# iam_groups                  <nil>
# iam_tags                    <nil>
# max_sts_ttl                 0s
# permissions_boundary_arn    n/a
# policy_arns                 [arn:aws:iam::aws:policy/ReadOnlyAccess]
# policy_document             n/a
# role_arns                   <nil>
# user_path                   n/a


vault write aws/roles/my-ec2-test-role credential_type=iam_user policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1426528957000",
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

vault write aws/roles/my-ec2-test-role credential_type=federation_token policy_document=@./workspace/myscripts/policy.json

# Using assume role to access another aws account

vault write aws/roles/s3_access \
  role_arn=arn:aws:iam:003454577:role/vault-role-bucket-access
  credential_type=assumed_role

vault write aws/sts/s3_access -ttl=60m

# To create a dynamic IAM ser with a specific role

vault read aws/creds/s3_access
