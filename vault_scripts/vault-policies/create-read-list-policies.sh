# vault policy delete/fmt/list/read/write


vault policy list

# dbreadonlyaccess
# default
# demoreadonly
# webreadonlyaccess
# root

# To read the policies

vault policy read default

# To create a token with a specific policy

vault token create -policy="web-app"

# WARNING! The following warnings were returned from Vault:
# 
  # * Policy "web-app" does not exist
# 
# Key                  Value
# ---                  -----
# token                hvs.CAESILYXkAoxt0coOQk130TvgbgQcEXZ-w0KZjNqwsOgbyVMGh4KHGh2cy5BN0dQUktCZW5PcUVpQnlYcXB4cm5qNzY
# token_accessor       xDwrb8mHLxUluzMnYUvTOicS
# token_duration       768h
# token_renewable      true
# token_policies       ["default" "web-app"]
# identity_policies    []
# policies             ["default" "web-app"]



