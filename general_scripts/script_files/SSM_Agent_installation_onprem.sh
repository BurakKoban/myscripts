# What you need is a "Hybrid Activation" code. To create a new CODE and ID, visit the AWS_Automation account in US-WEST-2 region and use the SSM console to generate a new set with a new expiration date.

# You can only pick up to 30 days out for the expiration. It will then display the CODE and ID but it will disappear forever and you'll have to generate a new code.

# Then when you go to install the SSM agent you specify the code as an install parameter like this for Windows:

AmazonSSMAgentSetup.exe /q CODE=$code ID=$id REGION=us-west-2

# For Red Hat 8:

mkdir /tmp/ssm
curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o /tmp/ssm/amazon-ssm-agent.rpm
sudo dnf install -y /tmp/ssm/amazon-ssm-agent.rpm
sudo systemctl stop amazon-ssm-agent
sudo -E amazon-ssm-agent -register -code "activation-code" -id "activation-id" -region "region"
sudo systemctl start amazon-ssm-agent
