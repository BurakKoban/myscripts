# to create cred from one accout into another AWS account

vault secrets enable aws

vault write aws/roles/s3_access \
    role_arns=arn:aws:iam::12345678:role/vault-role-bucket-access \ 
    credential_type=assumed_role

# To generate credentials
 
vault write aws/sts/s3_access -ttl=60m