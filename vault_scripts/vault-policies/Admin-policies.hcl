# Configure License

path "sys/license" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

# Initialize Vault

path "sys/init" {
    capabilities = ["create", "read", "update"]
}

# Configure UI in Vault

path "sys/config/ui" {
    capabilities = ["sudo", "read", "update", "delete", "list"]
}

# Allow rekey of unseal keys for Vault

path "sys/rekey/*" {
    capabilities = ["read", "update", "delete", "list"]
}

# Allows rotation of master key

path "sys/rotate" {
    capabilities = ["sudo", "update"]
}

# Allows Vault seal

path "sys/seal" {
    capabilities = ["sudo"]
}