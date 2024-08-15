resource "aws_instance" "sample_instance" {
    ami = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = var.ec2_instance_type
    key_name = aws_key_pair.sample_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.sg_8080.id]
    # subnet_id     = data.aws_subnet.my_subnet.id
    subnet_id = data.aws_subnets.my_subnets.ids[0]
    tags = {
     Name = "sample_ec2"
   }
}

resource "aws_security_group" "sg_8080" {
  name = "sample-ec2-sg"
  vpc_id      = data.aws_vpc.my_vpc.id
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


# Creates a pem file

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