vault write auth/approle/role/training-role \
    token_ttl=1h \
    token_max_ttl=24h