storage "dynamodb" {
  ha_enabled = "true"
  region     = "us-west-2"
  table      = "vault-data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable = 0
  tls_cert_file = "etc/vault.d/client.pem"
  tls_key_file = "etc/vault.d/cert.key"
  tls_disable_client_certs = "true"

}

seal "awskms" {
  region = "us-west-2"
  kms_key_id = "xxxxx-xxxx-xxxxx"
  endpoint = "example.kms.us-west-2.vpce.amazonaws.com"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://node-a.example.com:8201"
cluster_name = "vault_prod_us-west-2"
ui=true
disable_mlock = true
log_level = "INFO"
