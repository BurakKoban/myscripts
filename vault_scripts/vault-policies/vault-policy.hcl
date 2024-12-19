# Sample policy

path "*" {
    capabilities = ["read", "create", "update", "delete", "list", "sudo"]
}

# policy for webserver

path "secret/*" {
    capabilities = ["list"]

}

path "secret/webserver" {
    capabilities = ["read", "list"]

}

# policy for dbserver

path "secret/*" {
    capabilities = ["list"]
}

path "secret/dbserver" {
    capabilities = ["create", "read", "update", "delete", "list"]
}