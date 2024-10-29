variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}


variable "ec2_ami_id" {
  type    = string
  default = "ami-09ac7e749b0a8d2a1" # Amazon Linux 2023 for us-west-2
}

variable "key_name" {
  type    = string
  default = "burak_private_key"
}
