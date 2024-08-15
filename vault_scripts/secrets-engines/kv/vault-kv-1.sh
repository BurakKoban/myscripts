echo $VAULT_ADDR
export VAULT_ADDR="https://vault.ops.bcaa.bc.ca"
export VAULT_TOKEN="XXX.XXXXXXXXXXXXXXXXXXXXXXXX"
vault login

# enabling kv secret engine v1 with a custom path

vault secrets enable -path=secret kv

# enabling kv secret engine v2

vault secrets enable kv-v2

# enabling kv secret engine v2 

vault secrets enable -path=training -version=2 kv

# you can upgrade kc v1 to v2 with a custom path
# you cannot go back to v2 to v1

vault kv enable-versioning training/

# how to put and read secrets from/to Vault

vault kv put demo/test abc=123
vault kv get demo/test


# Sample automation command to get username and password from Vault

username=$(vault kv get demo/test | grep abc | cut -d" " -f1)
# abc

password=$(vault kv get demo/test | grep abc | cut -d" " -f5)
# 123

# To list the secrets

vault secrets list

vault secrets list -detailed

# output in json format

vault kv get -format=json demo/test

{
  "request_id": "0554076d-ab6d-e182-ad35-8212cbfa19fe",
  "lease_id": "",
  "lease_duration": 2764800,
  "renewable": false,
  "data": {
    "abc": "123"
  },
  "warnings": null
}

# To automate the result

vault kv get -format=json demo/test | jq .data.abc -j

123

vault kv get -format=json demo/test | jq .data.abc -r

123

# Deleting secrets

vault kv delete demo/data
# Success! Data deleted (if it existed) at: demo/data

vault kv get demo/data
# No value found at demo/data




