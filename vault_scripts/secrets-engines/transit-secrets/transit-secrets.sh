vault secrets enable transit
# Success! Enabled the transit secrets engine at: transit/

vault write -f transit/keys/vault_training 
# Success! Data written to: transit/keys/vault_training

# Custom key type

vault write -f transit/keys/vault_training_rsa type="rsa-4096"
# Success! Data written to: transit/keys/vault_training_rsa

# Encrypt Data

vault write transit/encrypt/training \
    plaintext=$(base64 <<< "Getting Started with HashiCorp Vault")

# Key            Value
# ---            -----
# ciphertext     vault:v1:ANITCACelJab4pNd1RcgNdXb8+frMMcurPpbRDXijII3u57ZF9y5MrLon6iqgDeSoPc5XdnUaqpEU3FbvlNfgcI=
# key_version    1

# Decrypt Data

vault write transit/decrypt/training \
    ciphertext="vault:v1:ANITCACelJab4pNd1RcgNdXb8+frMMcurPpbRDXijII3u57ZF9y5MrLon6iqgDeSoPc5XdnUaqpEU3FbvlNfgcI="

# Key          Value
# ---          -----
# plaintext    R2V0dGluZyBTdGFydGVkIHdpdGggSGFzaGlDb3JwIFZhdWx0Cg==
# echo "R2V0dGluZyBTdGFydGVkIHdpdGggSGFzaGlDb3JwIFZhdWx0Cg==" | base64 -d
# Getting Started with HashiCorp Vault

# Rotating keys

vault write -f transit/keys/training/rotate
# Success! Data written to: transit/keys/training/rotate

vault read transit/keys/training # To read the rotated key

# Key                       Value
# ---                       -----
# allow_plaintext_backup    false
# auto_rotate_period        0s
# deletion_allowed          false
# derived                   false
# exportable                false
# imported_key              false
# keys                      map[1:1675452959 2:1675453810]
# latest_version            2
# min_available_version     0
# min_decryption_version    1
# min_encryption_version    0
# name                      training

# To limit version key

vault write transit/keys/training/config \
    min_decryption_version=2
# Success! Data written to: transit/keys/training/config

vault read transit/keys/training

# Key                       Value
# ---                       -----
# allow_plaintext_backup    false
# auto_rotate_period        0s
# deletion_allowed          false
# derived                   false
# exportable                false
# imported_key              false
# keys                      map[2:1675453810]
# latest_version            2
# min_available_version     0
# min_decryption_version    2
# min_encryption_version    0
# name                      training
# supports_decryption       true
# supports_derivation       true
# supports_encryption       true
# supports_signing          false
# type                      aes256-gcm96

# rewrapping Ciphertext (encyrpt the same data with a newer version of the key)

vault write transit/rewrap/training \
    ciphertext="vault:v1:ANITCACelJab4pNd1RcgNdXb8+frMMcurPpbRDXijII3u57ZF9y5MrLon6iqgDeSoPc5XdnUaqpEU3FbvlNfgcI="






