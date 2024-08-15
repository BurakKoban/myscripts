# create a vault-config.hcl file

#run this command

vault server -config=./vault-config.hcl

  #  listener "tcp" {
  #      address = "0.0.0.0:8200"
  #      tls_disable = true
  #  }
  #
  #  storage "raft" {
  #      path = "./data"
  #      node_id = "node1"
  #  }
  #
  #  disable_mlock = true
  #
  #  api_addr = "http://127.0.0.1:8200"
  #  cluster_addr = "http://127.0.0.1:8201"
  #  ui = true 


# then you need to initiliaze the vault

vault operator init

# then you save the unseal keys and the initial token

# then you unseal the vault

vault operator unseal

vault status

#enabling vaulr logs

mkdir logs

vault audit enable file file_path=./workspace/vault/logs/vault_audit.log

#open up an other bash window

tail -f ./workspace/vault/logs/vault_audit.log | jq #keep it running if you want to see alive logs

# To see the service file

cd /etc/systemd/system

vi vault.service

# To manually join the nodes to the cluster that uses raft

vault operator raft join http://127.0.0.1:8200

# To list the cluster mambers

vault operator raft list-peers





