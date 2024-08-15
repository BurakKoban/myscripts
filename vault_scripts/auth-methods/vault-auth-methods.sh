# Configuring Auth Methods

# vault auth enable/disable/list/tune/help

vault auth enable approle  # Success! Enabled approle auth method at: approle/

vault auth enable -path=vault-sample approle  # Success! Enabled approle auth method at: vault-sample/

vault auth disable vault-sample    # Success! Disabled the auth method (if it existed) at: vault-sample/

vault auth enable -path=apps -description=MyApps approle  #Success! Enabled approle auth method at: apps/

vault auth enable userpass    # Success! Enabled userpass auth method at: userpass/

#   vault write auth/<path name>/<option>

vault write auth/approle/role/vault-course \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40

# To list the auth methods

vault auth list

# To change the TTL

vault auth tune -default-lease-ttl=24h apps/  # Success! Tuned the auth method at: apps/

vault write auth/userpass/users/burak password=abc123 policies=burak  # Success! Data written to: auth/userpass/users/burak

vault list auth/userpass/users 

# Keys
# ----
# burak

vault read auth/userpass/users/burak

# Key                        Value
# ---                        -----
# policies                   [burak]
# token_bound_cidrs          []
# token_explicit_max_ttl     0s
# token_max_ttl              0s
# token_no_default_policy    false
# token_num_uses             0
# token_period               0s
# token_policies             [burak]
# token_ttl                  0s
# token_type                 default

vault delete auth/userpass/users/test   # Success! Data deleted (if it existed) at: auth/userpass/users/test




vault write auth/approle/role/burak token_ttl=20m policies=burak   # Success! Data written to: auth/approle/role/burak

vault read auth/approle/role/burak

# Key                        Value
# ---                        -----
# bind_secret_id             true
# local_secret_ids           false
# policies                   [burak]
# secret_id_bound_cidrs      <nil>
# secret_id_num_uses         0
# secret_id_ttl              0s
# token_bound_cidrs          []
# token_explicit_max_ttl     0s
# token_max_ttl              0s
# token_no_default_policy    false
# token_num_uses             0
# token_period               0s
# token_policies             [burak]
# token_ttl                  20m
# token_type                 default













