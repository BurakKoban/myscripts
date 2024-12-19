variable "vpc_name" {
  type    = string
  default = "burak-test-mq-ca-vpc"
}

variable "cdir" {
  type    = string
  default = "192.168.128.0/24"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}


variable "key_name" {
  type    = string
  default = "burak_private_key"
}