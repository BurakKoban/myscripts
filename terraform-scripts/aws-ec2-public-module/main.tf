module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name = "test-ec2"

  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.sample_key_pair.key_name
  # monitoring             = true
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  availability_zone      = data.aws_availability_zones.available.names[1]
  vpc_security_group_ids = [aws_security_group.sg_80.id]
  subnet_id     = data.terraform_remote_state.vpc_module.outputs.private_subnets[1]
  metadata_options = { "http_endpoint": "enabled", "http_put_response_hop_limit": 1, "http_tokens": "required" }
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  
  /*root_block_device = [
    "volume_size = 30",
    "volume_type = gp3",
    "encrypted   = true",
    "kms_key_id  = arn:aws:kms:ca-central-1:675097064651:key/36315e83-decd-4127-9362-b5148a1c5749"
     ] */
  
  

  user_data = <<-EOF
              #!/bin/bash
              yum update
              yum install -y httpd
              echo "Hello World from Burak" > /var/www/html/index.html
              systemctl restart httpd
              EOF

  tags = {
    Terraform = "true"
    Environment = "mq_ca"
  }

/* To Create Spot Instance */
/*
  create_spot_instance = true
  spot_price           = "0.60"
  spot_type            = "persistent"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  } */
} 

resource "aws_security_group" "sg_80" {
  name = "sample-ec2-sg"
  vpc_id      = data.terraform_remote_state.vpc_module.outputs.vpc_id
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "rsa_4096" {
  algorithm     = "RSA"
  rsa_bits      = 4096
}


resource "aws_key_pair" "sample_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}