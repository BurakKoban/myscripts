curl --header "X-Vault-Token: hvs.XXXXXXXXXXXXXXXXXXXXXXXX" --request POST --data @auth.json http://127.0.0.1:8200/v1/sys/auth/approle

curl --header "X-Vault-Token: hvs.XXXXXXXXXXXXXXXXXXXXXXXX" --request POST --data @policies.json http://127.0.0.1:8200/v1/auth/approle/role/vaultcourse

#  curl --header "X-Vault-Token: hvs.XXXXXXXXXXXXXXXXXXXXXXXX" --request POST --data @auth.json https://vault.ops.bcaa.bc.ca/v1/sys/auth/approle  # To create an approle

#  curl --header "X-Vault-Token: hvs.XXXXXXXXXXXXXXXXXXXXXXXX" --request POST --data @policies.json https://vault.ops.bcaa.bc.ca/v1/auth/approle/role/vaultcourse # To create a role

curl --header "X-Vault-Token: hvs.XXXXXXXXXXXXXXXXXXXXXXXX" http://127.0.0.1:8200/v1/auth/approle/role/vaultcourse/role-id  | jq # To fetch the role id

{
  "request_id": "b8803ccc-e7cf-fbf3-e13d-4efab0a62c06",
  "lease_id": "",
  "renewable": false,
  "lease_duration": 0,
  "data": {
    "role_id": "3fca205e-a694-5ee1-54ae-387459b2549d"
  },
  "wrap_info": null,
  "warnings": null,
  "auth": null
}

# To get a secret id

curl --header "X-Vault-Token: hvs.hvs.XXXXXXXXXXXXXXXXXXXXXXXX" --request POST http://127.0.0.1:8200/v1/auth/approle/role/vaultcourse/secret-id | jq

{
  "request_id": "7483beac-03d1-354f-8bfe-3eec73bffaed",
  "lease_id": "",
  "renewable": false,
  "lease_duration": 0,
  "data": {
    "secret_id": "905b8d6b-39e1-de6a-0688-a68c8c1395cf",
    "secret_id_accessor": "b0b474ce-579c-fbba-3637-efdbc180314d",
    "secret_id_num_uses": 0,
    "secret_id_ttl": 0
  },
  "wrap_info": null,
  "warnings": null,
  "auth": null
}

# Using API to authenticate with okta

curl --request POST --data @password.json http://127.0.0.1:8200/v1/auth/okta/login/burak@koban.secret_id_bound_cidrs

