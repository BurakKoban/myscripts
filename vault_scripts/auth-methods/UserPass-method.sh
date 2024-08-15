vault auth enable userpass  # Success! Enabled userpass auth method at: userpass/

# To create users

vault write auth/userpass/users/johnny password=abc123 policies=burak  # Success! Data written to: auth/userpass/users/johnny

# To create a second user

vault write auth/userpass/users/jamie password=abc456 policies=burak # Success! Data written to: auth/userpass/users/jamie

# To See the list of the users

vault list auth/userpass/users 

# Keys
# ----
# jamie
# johnny

# To See the configuration of a user 

vault read auth/userpass/users/jamie 

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

# To delete a user

vault delete auth/userpass/users/test   # Success! Data deleted (if it existed) at: auth/userpass/users/test

# To login with one of these users

vault login -method=userpass username=jamie
Password (will be hidden): 

# WARNING! The VAULT_TOKEN environment variable is set! The value of this
# variable will take precedence; if this is unwanted please unset VAULT_TOKEN or
# update its value accordingly.
# 
# Success! You are now authenticated. The token information displayed below
# is already stored in the token helper. You do NOT need to run "vault login"
# again. Future Vault requests will automatically use this token.
# 
# Key                    Value
# ---                    -----
# token                  ???
# token_accessor         sXnz1BXZspLE7V9wWVrWEQnn
# token_duration         768h
# token_renewable        true
# token_policies         ["burak" "default"]
# identity_policies      []
# policies               ["burak" "default"]
# token_meta_username    jamie

