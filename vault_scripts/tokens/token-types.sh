hvs.xxxxx ---> service token
hvb.xxxxx ---> batch token
hvr.xxxxx ---> recovery token

# Periodic Token is a token without max_ttl , you can renew it as much as you want.

vault token create -policy=readonly-policy -period=24h

# Key                  Value
# ---                  -----
# token                hvs.CAESIG91AzK6v0M6vVI9P8uOkUK6I0ksyB73zETDgoBJtbZeGh4KHGh2cy44OEtjRkNUV2ZibHlpdzdRVHZCWGtEVGU
# token_accessor       Nn4wVHywTIfpWhPNcIAWqmdI
# token_duration       24h
# token_renewable      true
# token_policies       ["default" "readonly-policy"]
# identity_policies    []
# policies             ["default" "readonly-policy"]

# To create a token with number of uses

vault token create -policy=readonly-policy -period=24h -use-limit=2


vault token lookup hvs.CAESIG91AzK6v0M6vVI9P8uOkUK6I0ksyB73zETDgoBJtbZeGh4KHGh2cy44OEtjRkNUV2ZibHlpdzdRVHZCWGtEVGU

# Key                 Value
# ---                 -----
# accessor            Nn4wVHywTIfpWhPNcIAWqmdI
# creation_time       1692641004
# creation_ttl        724h
# display_name        token
# entity_id           n/a
# expire_time         2023-08-22T11:03:24.9686877-07:00
# explicit_max_ttl    0s
# id                  hvs.CAESIG91AzK6v0M6vVI9P8uOkUK6I0ksyB73zETDgoBJtbZeGh4KHGh2cy44OEtjRkNUV2ZibHlpdzdRVHZCWGtEVGU
# issue_time          2023-08-21T11:03:24.9686964-07:00
# meta                <nil>
# num_uses            0
# orphan              false
# path                auth/token/create
# period              24h
# policies            [default readonly-policy]
# renewable           true
# ttl                 23h58m50s
# type                service

vault auth enable approle

# To create a token with batch type

vault write auth/approle/role/training policies=training \
    token_type=batch
    token_ttl=60s

vault write auth/approle/role/jenkins policies=jenkins \
    period=72H