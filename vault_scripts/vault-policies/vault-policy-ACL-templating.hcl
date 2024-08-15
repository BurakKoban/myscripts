path "secret/dbserver/+/app" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

# + means that we can put anything between these 2 /

path "secret/data/{{identity.entity.id}}/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

# permissions depending on {{identity.entity.id}} (user entity) 