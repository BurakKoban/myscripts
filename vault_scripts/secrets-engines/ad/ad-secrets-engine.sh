vault secrets enable ad


vault write ad/config \
        binddn='CN=gremlin,OU=Special Accounts,DC=bcaa,DC=bc,DC=ca' \
        bindpass='8a.v(-9WxZ=<vf\/' \
        url=ldaps://inf-prd-dom005.bcaa.bc.ca \
        userdn='OU=Special Accounts,DC=bcaa,DC=bc,DC=ca' \
        insecure_tls=true

# Rotate the root credential

vault write -f ad/rotate-root


vault write ad/roles/hcp-team \
    service_account_name="hcptestuser1@bcaa.com"

cat <<EOF | vault policy write hcp-team-policy -
path "ad/creds/hcp-team" {
  capabilities = ["read"]
}
EOF


vault write ad/library/hcp-team \
        service_account_names="hcptestuser1@bcaa.com" \
        ttl=1h \
        max_ttl=2h \
        disable_check_in_enforcement=false

vault read ad/library/hcp-team/status

vault write -f ad/library/hcp-team/check-out

vault write -f ad/library/hcp-team/check-in