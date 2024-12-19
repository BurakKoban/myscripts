curl --request POST --data @payload.json http://127.0.0.1:8200/v1/auth/userpass/login/test | jq

# {
  # "request_id": "f1115f88-15c1-d5a4-75fa-5df06c5e5b4e",
  # "lease_id": "",
  # "renewable": false,
  # "lease_duration": 0,
  # "data": null,
  # "wrap_info": null,
  # "warnings": null,
  # "auth": {
    # "client_token": "hvs.CAESIHCZKgpsd2i5hdbpF2BwaCFfuNHo_2-r6TyeX3v85h3AGh4KHGh2cy5FdWVGU1h4VkhlbVdpZ25DUFZFbXplbnE",
    # "accessor": "5NXcPi5mw5Yk1kbpQZxlspdM",
    # "policies": [
      # "default",
      # "readonly-policy"
    # ],
    # "token_policies": [
      # "default"
    # ],
    # "identity_policies": [
      # "readonly-policy"
    # ],
    # "metadata": {
      # "username": "test"
    # },
    # "lease_duration": 2764800,
    # "renewable": true,
    # "entity_id": "173c2c48-1d0c-1040-ceb6-97094bc5c861",
    # "token_type": "service",
    # "orphan": true,
    # "mfa_requirement": null,
    # "num_uses": 0
  # }
# }

curl --request POST --data @payload.json http://127.0.0.1:8200/v1/auth/userpass/login/test | jq -r ".auth.client_token" # To get the token

# hvs.CAESIH2SMu4-pu00j9Se3aueCRkIVNCms3MuVkoVzzBX072XGh4KHGh2cy5OWXVNYTNBckVXSGJBR3NWeGQwUDQ4eTc

OUTPUT=$(curl --request POST --data @payload.json http://127.0.0.1:8200/v1/auth/userpass/login/test)
VAULT_TOKEN=$(echo $OUTPUT | jq '.auth.client_token' -j)
echo $VAULT_TOKEN

# To write data and read it 

curl --header "X-Vault-Token: hvs.F3SK3CacmaGA5nhANLCdBJFM" \
    --request POST --data '{"api_key":"sdgfsjkfkajfk111"}' \
    http://127.0.0.1:8200/v1/secret/demo

curl --header "X-Vault-Token: hvs.F3SK3CacmaGA5nhANLCdBJFM" \
    --request GET \
    http://127.0.0.1:8200/v1/secret/demo
