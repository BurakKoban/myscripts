sudo adduser new_user

sudo adduser deangr --disabled-password

sudo su - new_user

mkdir .ssh

chmod 700 .ssh

touch .ssh/authorized_keys

chmod 600 .ssh/authorized_keys

# To put the new user as sudoer

cat /etc/sudoers
