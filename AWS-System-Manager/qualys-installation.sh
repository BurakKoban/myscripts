# To install Qualys on Amazon Linux, RHEL, CentOS

curl -s -o /tmp/QualysCloudAgent.rpm https://d7gs59d1yhaqs.cloudfront.net/QualysCloudAgent.rpm
sudo rpm -ivh /tmp/QualysCloudAgent.rpm
/usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh \
ActivationId=bde49e8c-1021-479a-87ef-8da084be7ce6 \
CustomerId=476e0130-4613-db6c-80e4-3c8bef246e33 \
ServerUri=https://qagpublic.qg3.apps.qualys.com/CloudAgent/

# To check the status of the installation

systemctl status qualys-cloud-agent

# To install Qualys on Ubuntu

curl -s -o /tmp/QualysCloudAgent.deb https://d7gs59d1yhaqs.cloudfront.net/QualysCloudAgent.deb
sudo dpkg -i /tmp/QualysCloudAgent.deb
/usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh \
ActivationId=bde49e8c-1021-479a-87ef-8da084be7ce6 \
CustomerId=476e0130-4613-db6c-80e4-3c8bef246e33 \
ServerUri=https://qagpublic.qg3.apps.qualys.com/CloudAgent/

# To check the status of the installation

systemctl status qualys-cloud-agent


# To install Qualys on Ubuntu Arm64

curl -s -o /tmp/QualysCloudAgent_arm64.deb https://d7gs59d1yhaqs.cloudfront.net/QualysCloudAgent_arm64.deb
sudo dpkg -i /tmp/QualysCloudAgent_arm64.deb
/usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh \
ActivationId=bde49e8c-1021-479a-87ef-8da084be7ce6 \
CustomerId=476e0130-4613-db6c-80e4-3c8bef246e33 \
ServerUri=https://qagpublic.qg3.apps.qualys.com/CloudAgent/

# To check the status of the installation

systemctl status qualys-cloud-agent