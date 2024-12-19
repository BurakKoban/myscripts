# enabling kv secret engine v2

vault secrets enable kv-v2


# enabling kv secret engine v2 

vault secrets enable -path=training -version=2 kv -description="Burak's kv store"

# you can upgrade kc v1 to v2 with a custom path
# you cannot go back to v2 to v1

vault kv enable-versioning training/

# how to put and read secrets from/to Vault by using kv-v2

vault kv put secretv2/data pass=123

# === Secret Path ===
# secretv2/data/data
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:26:19.7880098Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            1

# how to put several secrets

vault kv put secretv2/app-secrets pass=123 user=admin api=a6fje74mfbbmh

# how to put many secrets on a json file 

vault kv put secretsv2/app2-secrets @secrets.json

secrets.json : {
    "pass":"123"
    "user":"admin"
    "api":"a6fje74mfbbmh"
}

# how to get secrets 

vault kv get secretv2/app-secrets

# ======= Secret Path =======
# secretv2/data/app-secrests
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:29:51.163292Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            1
# 
# ==== Data ====
# Key     Value
# ---     -----
# api     a6fje74mfbbmh
# pass    123
# user    admin

# if we put a new secret with just one of them

vault kv put secretv2/app-secrets api=abc123fgh567

# when you read the path, it update everything , not just one of them , in this case it is api

vault kv get secretv2/app-secrets

# ======= Secret Path =======
# secretv2/data/app-secrests
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:40:49.7407753Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            2
# 
# === Data ===
# Key    Value
# ---    -----
# api    abc123fgh567

# We can roll back

vault kv rollback -version=1 secretv2/app-secrets

# Key                Value
# ---                -----
# created_time       2023-01-30T23:44:31.6270035Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            3

vault kv get secretv2/app-secrets

# ======= Secret Path =======
# secretv2/data/app-secrests
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:44:31.6270035Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            3
# 
# ==== Data ====
# Key     Value
# ---     -----
# api     a6fje74mfbbmh
# pass    123
# user    admin

# whatif we want to change only one of them

vault kv patch secretv2/app-secrets user=burak

# ======= Secret Path =======
# secretv2/data/app-secrests
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:47:40.3773425Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            4

vault kv get secretv2/app-secrets

# ======= Secret Path =======
# secretv2/data/app-secrests
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:47:40.3773425Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            4
# 
# ==== Data ====
# Key     Value
# ---     -----
# api     a6fje74mfbbmh
# pass    123
# user    burak

# To get any version of the secret

vault kv get -version=3 secretv2/app-secrets

# ======= Secret Path =======
# secretv2/data/app-secrests
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:44:31.6270035Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            3
# 
# ==== Data ====
# Key     Value
# ---     -----
# api     a6fje74mfbbmh
# pass    123
# user    admin

# Deleting secrets

vault kv delete secretv2/data
# Success! Data deleted (if it existed) at: secretv2/data/data

vault kv get secretv2/data

# === Secret Path ===
# secretv2/data/data
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:26:19.7880098Z
# custom_metadata    <nil>
# deletion_time      2023-01-31T21:18:03.434473Z
# destroyed          false
# version            1

# To undelete the data

vault kv undelete -versions=1 secretv2/data
# Success! Data deleted (if it existed) at: secretv2/data/data

vault kv get secretv2/data

# === Secret Path ===
# secretv2/data/data
# 
# ======= Metadata =======
# Key                Value
# ---                -----
# created_time       2023-01-30T23:26:19.7880098Z
# custom_metadata    <nil>
# deletion_time      n/a
# destroyed          false
# version            1
# 
# ==== Data ====
# Key     Value
# ---     -----
# pass    123

# To destroy secrets

vault kv destroy -versions=3 secretv2/app-secrets
# Success! Data written to: secretv2/destroy/app-secrets

# To see our matedata

vault kv metadata get secretv2/data

# ==== Metadata Path ====
# secretv2/metadata/data
# 
# ========== Metadata ==========
# Key                     Value
# ---                     -----
# cas_required            false
# created_time            2023-01-30T23:26:19.7880098Z
# current_version         1
# custom_metadata         <nil>
# delete_version_after    0s
# max_versions            0
# oldest_version          0
# updated_time            2023-01-30T23:26:19.7880098Z
# 
# ====== Version 1 ======
# Key              Value
# ---              -----
# created_time     2023-01-30T23:26:19.7880098Z
# deletion_time    n/a
# destroyed        false




