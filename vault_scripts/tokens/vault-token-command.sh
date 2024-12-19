vault token -h

# capabilities    Print capabilities of a token on a path
# create          Create a new token
# lookup          Display information about a token
# renew           Renew a token lease
# revoke          Revoke a token and its children

vault token create -ttl=5m -policy=training

# WARNING! The following warnings were returned from Vault:
# 
  # * Policy "training" does not exist
# 
# Key                  Value
# ---                  -----
# token                hvs.CAESIJOjVAg5e84SQziO9y7XYhk19otQphHFZ45oBpl9SLOYGh4KHGh2cy5UR0VnNGExVHhoTE5qYWd2ZHBrWHpJTzI
# token_accessor       E3Ibsr585EmmeSaZeB3uSpdx
# token_duration       5m
# token_renewable      true
# token_policies       ["default" "training"]
# identity_policies    []
# policies             ["default" "training"]

vault token revoke hvs.CAESIJOjVAg5e84SQziO9y7XYhk19otQphHFZ45oBpl9SLOYGh4KHGh2cy5UR0VnNGExVHhoTE5qYWd2ZHBrWHpJTzI

# Success! Revoked token (if it existed)

# To see the capabilities for a certain path with a specific token

vault token capabilities hvs.CAESIJOjVAg5e84SQziO9y7XYhk19otQphHFZ45oBpl9SLOYGh4KHGh2cy5UR0VnNGExVHhoTE5qYWd2ZHBrWHpJTzI kv/data/apss/webapp

# read, list



