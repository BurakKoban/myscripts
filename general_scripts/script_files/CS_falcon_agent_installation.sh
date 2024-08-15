# install Falcon

curl -s -o /tmp/falcon-sensor.amzn2.x86_64.rpm https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor-6.56.0-15309.amzn2023.x86_64.rpm
yum install -y /tmp/falcon-sensor.amzn2.x86_64.rpm
/opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
systemctl restart falcon-sensor


# Ubuntu 22.04

curl -s -o /tmp/falcon-sensor_7.03.0-15805_amd64.deb https://d7gs59d1yhaqs.cloudfront.net/falcon-sensor_7.03.0-15805_amd64.deb
apt install -y /tmp/falcon-sensor_7.03.0-15805_amd64.deb
/opt/CrowdStrike/falconctl -s --cid=CE518243D4DB48EBAF7E10B170F5A782-BE
systemctl restart falcon-sensor

