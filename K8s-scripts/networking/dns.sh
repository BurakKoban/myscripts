# To add a dns name to a node

cat >> /etc/hosts << EOF
192.168.1.11 db-node1
EOF

# To specify a central DNS server

cat /etc/resolv.conf

# To switch the entry from local host to central DNS

cat /etc/nsswitch.conf  


