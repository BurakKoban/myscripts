# long-running app which cannot handle the regeneration of a token or secret 
# no max TTL

Periodic Service Token

vault token create -policy=training -period=24h  # with no max TTL

# For a token that gets revoked after one use

Service Token with Use limit

vault token create -policy=training -use-limit=2

# My app can't use a token where its expiration is influenced by its parent

Orphan Service Token

vault token create -policy=training -orphan

CIDR-Bound Token