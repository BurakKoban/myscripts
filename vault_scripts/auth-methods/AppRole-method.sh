vault auth enable approle  # Success! Enabled approle auth method at: approle/

vault auth enable -path=vault-course -description=MyApps approle # Success! Enabled approle auth method at: vault-course/

# To disable auth method

vault auth disable vault-course # Success! Disabled the auth method (if it existed) at: vault-course/

# To create a Role

vault write auth/approle/role/burak \
    policies=readonly-policy \
    token_ttl=20m \  
    secret_id_ttl=10m \
    token-num_uses=15 \
    token_max_ttl=30m \
    secret_id_num_uses=50   # Success! Data written to: auth/approle/role/burak

# To see what roles you have under Approle

vault list auth/approle/role   

# Keys
# ----
# burak

# To get the Role ID

vault read auth/approle/role/burak/role-id  

# Key        Value
# ---        -----
# role_id    c92a8bc4-917b-7f1c-412b-ee87dee64bf8

# To generate a secret ID

vault write -f auth/approle/role/burak/secret-id 

# Key                   Value
# ---                   -----
# secret_id             5cf0861b-ce03-8f4e-8db4-dbe01105dc93
# secret_id_accessor    a0e5dcea-b657-8e25-6da0-4b6b08414a12
# secret_id_num_uses    0
# secret_id_ttl         0s

# To authenticate with this Approle

vault write auth/approle/login role_id=c92a8bc4-917b-7f1c-412b-ee87dee64bf8 secret_id=5cf0861b-ce03-8f4e-8db4-dbe01105dc93

# Key                     Value
# ---                     -----
# token                   hvs.CAESIOcZxN-CAJ-6msNINBT_yYicjBMbPKxHWzWr3Acn4t2SGh4KHGh2cy54alJ2Z2NFVmlLMHdaNnpaOGI5VHJUWUY
# token_accessor          pj1RVd1nEe6iLnpCASteZBpp
# token_duration          20m
# token_renewable         true
# token_policies          ["burak" "default"]
# identity_policies       []
# policies                ["burak" "default"]
# token_meta_role_name    burak
