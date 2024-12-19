# for ubuntu
# Download the package first then 

sudo dpkg -i /opt/falcon-sensor_4.16.0-6101_amd64.dbe01105dc93

# assign the costumer ID

sudo /opt/CrowdStrike/falconctl -s --cid=012345asdfg-we

# start the service

sudo service falcon-sensor start

# for Amazon Linux 2
# Download the package first then

sudo yum install /opt/falcon-sensor_4.16.0-6101.e17.x86_64.rpm

sudo /opt/CrowdStrike/falconctl -s --cid=012345asdfg-we

sudo systemctl falcon-sensor start

# How to check the version of falcon-sensor running 

sudo /opt/CrowdStrike/falconctl -g --version

# For Amazon Linux 2023

curl -s -o /tmp/falcon-sensor-6.56.0-15309.amzn2023.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.56.0-15309.amzn2023.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor-6.56.0-15309.amzn2023.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# For Amazon Linux 1

curl -s -o /tmp/falcon-sensor-6.50.0-14713.amzn1.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.50.0-14713.amzn1.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor-6.50.0-14713.amzn1.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# For Amazon Linux 2

curl -s -o /tmp/falcon-sensor.amzn2.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.50.0-14713.amzn2.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor.amzn2.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

curl -s -o /tmp/falcon_diagnostic_3.9.7.sh https://d7gs59d1yhaqs.cloudfront.net/falcon_diagnostic_3.9.7.sh


# For Ubuntu 

curl -s -o /tmp/falcon-sensor_7.18.0-17106_amd64.deb https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor_7.18.0-17106_amd64.deb
sudo dpkg -i /tmp/falcon-sensor_7.18.0-17106_amd64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# For Ubuntu arm64

curl -s -o /tmp/falcon-sensor_6.50.0-14713_arm64.deb https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor_6.50.0-14713_arm64.deb
sudo dpkg -i /tmp/falcon-sensor_6.50.0-14713_arm64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# Ubuntu 22.04

curl -s -o /tmp/falcon-sensor_7.03.0-15805_amd64.deb https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor_7.03.0-15805_amd64.deb
sudo apt install -y /tmp/falcon-sensor_7.03.0-15805_amd64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor



# For RHEL 9

curl -s -o /tmp/falcon-sensor-6.49.0-14604.el9.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.49.0-14604.el9.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor-6.49.0-14604.el9.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# For RHEL 8 

curl -s -o /tmp/falcon-sensor-6.50.0-14712.el8.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.50.0-14712.el8.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor-6.50.0-14712.el8.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# For RHEL 7

curl -s -o /tmp/falcon-sensor-6.50.0-14712.el7.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.50.0-14712.el7.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor-6.50.0-14712.el7.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo systemctl restart falcon-sensor

# For RHEL 6

curl -s -o /tmp/falcon-sensor-6.54.0-15110.el6.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.54.0-15110.el6.x86_64.rpm
sudo yum install -y /tmp/falcon-sensor-6.54.0-15110.el6.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
sudo service falcon-sensor restart
