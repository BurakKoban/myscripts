# Parsing the JSON Response to obtain the Vault token

export VAULT_ADDR="https://vault.example.com:8200"

export VAULT_FORMAT=json

OUTPUT=$(vault write auth/approle/login role_id="123456" secret_id="1nvhf34rhrh")

VAULT_TOKEN="$(acho $OUTPUT | jq '.auth.client_token' -j)"

vault login $VAULT_TOKEN



