vault auth enable okta # Success! Enabled okta auth method at: okta/

# Then create an API token in Okta

vault write auth/okta/config base_url="okta.com" org_name="Koban" api_token="2cy54alJ2Z2NFVmlLMHdaNnpaOGI5VHJUWUY" # Success! Data written to: auth/okta/config

# To Read that back

vault read auth/okta/config

#    Key                        Value
#    ---                        ----- 
#    base_url                   okta.com 
#    bypass_okta_mfa            false 
#    org_name                   Koban 
#    organization               Koban 
#    token_bound_cidrs          [] 
#    token_explicit_max_ttl     0s 
#    token_max_ttl              0s 
#    token_no_default_policy    false 
#    token_num_uses             0 
#    token_period               0s 
#    token_policies             [] 
#    token_ttl                  0s 
#    token_type                 default 

# To setup a user

vault write auth/okta/users/burak.koban@example.com policies=burak # Success! Data written to: auth/okta/users/burak.koban@example.com



