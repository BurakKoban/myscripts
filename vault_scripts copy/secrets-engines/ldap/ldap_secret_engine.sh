# First we need to enable the ldap secret engine 

vault secrets enable ldap

# Configures the LDAP secrets engine using the ldap plugin to communicate with our ldap server

vault write ldap/config \
    binddn='CN=gremlin,OU=Special Accounts,DC=bcaa,DC=bc,DC=ca' \
    bindpass='8a.v(-9WxZ=<vf\/' \
    url=ldaps://inf-prd-dom005.bcaa.bc.ca:636

# Rotate the root credential

vault write -f ldap/rotate-root

# Create a role named learn with a rotation period of 24 hours.
    
vault write ldap/static-role/learn \
    dn='CN=HCP-test 1,OU=TEST,OU=Domain Clients,DC=bcaa,DC=bc,DC=ca' \
    username='hcptestuser1' \
    rotation_period="45m"


# Request LDAP credential from the learn role

path "ldap/static-cred/learn" {
  capabilities = [ "read" ]
}

# Request a new password by reading the learn role

vault read ldap/static-cred/learn

#    Key                    Value
#    ---                    -----
#    dn                     CN=HCP-test 1,OU=TEST,OU=Domain Clients,DC=bcaa,DC=bc,DC=ca
#    last_password          n/a
#    last_vault_rotation    2023-05-25T14:21:54.6356076-07:00
#    password               VG5WEwsukH1Ezh5pS1187vrAEUDXYJYcFm73gRwwQDe9xHJ3Kvq97w2gQ4AOhdGL
#    rotation_period        24h
#    ttl                    23h59m16s
#    username               hcptestuser1

# Generate another set of credentials from the learn role and save the password to a variable named LDAP_PASSWORD

LDAP_PASSWORD=$(vault read --format=json ldap/static-cred/learn | jq -r ".data.password")

# With the new password saved as a variable, perform an LDAP search with the generated password

ldapsearch -b "CN=HCP-test 1,OU=TEST,OU=Domain Clients,DC=bcaa,DC=bc,DC=ca" \
    -D 'CN=HCP-test 1,OU=TEST,OU=Domain Clients,DC=bcaa,DC=bc,DC=ca' \
    -w $LDAP_PASSWORD
