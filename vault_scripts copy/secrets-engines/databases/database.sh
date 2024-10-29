vault secrets enable -path=mysql database
# Success! Enabled the database secrets engine at: mysql/

vault write mysql/config/mysql-database \
    plugin_name=mysql-rds-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(prod.cluster.us-west-2.rds.amazonaws.com:3306)/" \
    allowed_roles="advanced" \
    username="admin" \
    password="abcd1234"

vault write mysql/roles/advanced \
    db_name=mysql-database \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"
# Success! Data written to: mysql/roles/advanced

vault read mysql/roles/advanced

# Key                      Value
# ---                      -----
# creation_statements      [CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';]
# credential_type          password
# db_name                  mysql-database
# default_ttl              1h
# max_ttl                  24h
# renew_statements         []
# revocation_statements    []
# rollback_statements      []

# To rotate the credentials for the Database

vault write -f mysql/rotate-root/mysql-database
# Success! Data written to: mysql/rotate-root/mysql-database


vault read mysql/creds/advanced

# Key  Value
# ---  -----
# lease_id          mysql/creds/advanced/abcd-deft-1234-5678
# lease_duration    1h
# lease_renewable   true
# password          dbhdhbjhbshb
# username          VAULT_MY_ROLE_SJUKYFDDD_FGTE

# To revoke credentials for a specific one

vault lease revoke mysql/creds/advanced/abcd-deft-1234-5678

# To revoke credentials for all of them

vault lease revoke -prefix mysql/creds/advanced