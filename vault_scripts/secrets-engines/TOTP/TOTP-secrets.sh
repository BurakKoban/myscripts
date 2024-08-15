# Setting up Vault as an MFA device 

vault secrets enable totp 
# Success! Enabled the totp secrets engine at: totp/

vault write totp/keys/aws \
    url="otpauth://totp/Amazon%20Web%20Services:totp@634211456147?secret=KBSDKJSDVKJ;NVJ8U3859T7JKNVKJDFVN89TYU458HJDFNVJDKNG"

# To retrieve the MFA code

vault read totp/code/aws

