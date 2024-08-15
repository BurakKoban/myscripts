variable "vpc_name" {
  type    = string
  default = "burak-test-mq-ca-vpc"
}

variable "vpc_cdir" {
  type    = string
  default = "192.168.128.0/24"
}

variable "vpc_subnet_1" {
  type    = string
  default = "192.168.128.0/26"
}
