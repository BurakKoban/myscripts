vault secrets enable pki
# Success! Enabled the pki secrets engine at: pki/

vault secrets tune -max-lease-ttl=87600h pki
# Success! Tuned the secrets engine at: pki/

vault write -field=certificate pki/generate/internal \
    common_name="burakweb.com" \
    ttl=87600h > ca_cert.crt

vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
    crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl" 
# Success! Data written to: pki/config/urls

vault secrets enable -path=pki_int pki
# Success! Enabled the pki secrets engine at: pki_int/

vault secrets tune -max-lease-ttl=43800h pki_int
# Success! Tuned the secrets engine at: pki_int/

vault write -format=json pki_int/intermediate/generate/internal \
    common_name="burakweb.com Intermediate Authority" \
    | jq -r '.data.csr'  > pki_intermediate.csr

vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
    format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem

vault write pki_int/intermediate/set-signed certficate=@intermediate.cert.pem

vault write pki_int/roles/burakweb \
    allowed_domains="burakweb.com" allow_subdomains=true max_ttl="720h"

vault write pki_int/issue/burakweb common_name="learn.burakweb.com" ttt="24h"