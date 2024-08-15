variable "default_profile" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "intra_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "vpc_interconnection" {
  type    = bool
  default = true
}

variable "tgw_igw" {
  type    = bool
  default = true
}

variable "tgw_across_region" {
  type    = bool
  default = true
}

variable "zone_enabled" {
  type    = bool
  default = true
}

variable "acm_enabled" {
  type    = bool
  default = true
}