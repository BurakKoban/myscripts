vault secrets disable/enable/list/move/tune

vault secrets enable aws

vault secrets tune -default-lease-ttl=72h pki/

vault secrets list -detailed

vault secrets enable -path=developers kv

vault secrets enable -description="my first kv" kv

vault secrets enable -description="Static Secrets" -path="cloud-kv" kv-v2 

