ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa 
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519

# To specify a file name

ssh-keygen -f ~/tatu-key-ecdsa -t ecdsa -b 521

# Copying the Public Key to the Server

ssh-copy-id -i ~/.ssh/tatu-key-ecdsa user@host

ssh-keygen -p -f my_private_key.pem

#-y Read private key file and print public key.
#-f Filename of the key file.

ssh-keygen -y -f myfile-privkey.pem

# generate a SSH key pair using ssh-keygen

ssh-keygen -t ed25519 -b 4096 -C "burak.koban@bcaa.com" -f burakvdikey

# To create a new key pair

ssh-keygen -t rsa -b 2048