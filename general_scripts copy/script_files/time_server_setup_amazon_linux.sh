# Configure the Amazon Time Sync Service
sudo yum erase 'ntp*' -y
sudo yum install chrony -y
sudo echo "server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4" | cat - /etc/chrony.conf > /tmp/chrony.conf.temp && sudo mv /tmp/chrony.conf.temp /etc/chrony.conf
sudo service chronyd restart
sudo chkconfig chronyd on

# To verify

chronyc sources -v
chronyc tracking