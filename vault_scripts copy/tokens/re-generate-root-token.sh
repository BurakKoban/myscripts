vault operator generate-root -init

# then we get OTP 

vault operator generate-root

# Then we enter 3 of 5 unseal keys
# Then we receive encoded root token

vault operator generate-root \  
    -otp="hhjsbjksbdjksvb" \
    -decode="jhgdfhsgdkjafajkfbakjfbajkfbakj"

# Then we get the root token
