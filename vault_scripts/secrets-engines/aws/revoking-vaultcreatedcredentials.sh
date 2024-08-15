vault lease revoke aws/creds/my-ec2-test-role/REJg71gUELCGyMZlzT55MQ3H

# if you want to revoke all the dynamic credentials on a certain path created by Vault

vault vault lease revoke -prefix aws/creds/my-ec2-test-role