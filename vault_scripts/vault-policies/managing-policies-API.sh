curl --header "X-Vault-Token:  hvs.CAESILNcP-AfJqVDPvvDhPoOoyAd96xtqCT7C6Sh" \
    --request PUT \
    --data @vault-policy.hcl \
    http://127.0.0.1:8200/v1/sys/policy/webapp