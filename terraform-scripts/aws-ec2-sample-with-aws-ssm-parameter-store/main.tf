module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name                   = "test-ec2"
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.sample_key_pair.key_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = "subnet-03cad52c862d23f4c"
  root_block_device = [
    {
    volume_size       = "10"
    type              = "gp3"
    encrypted         = true
    kms_key_id        = data.aws_ssm_parameter.kms_key_arn.value
  }
  ]

  user_data = <<-EOF
            #!/bin/bash
            yum update
            yum install -y httpd
            echo "Hello World from Burak" > /var/www/html/index.html
            systemctl restart httpd
            EOF

  tags = {
    Creator                      = "Burak"
    Department                   = "IS"
    Description                  = "ec2 ebs-type test"
    TicketNumber                 = "TASK00000000"
    Environment                  = "Test"
  }
}



module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "test-ec2-sg"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress_cidr_blocks = ["10.201.10.243/32"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]

 
}

# Creates a pem file

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "sample_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}