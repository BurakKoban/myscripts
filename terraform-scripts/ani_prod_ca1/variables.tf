variable "default_profile" {
  type = string
}

variable "region" {
  type    = string
  default = "ca-central-1"
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

variable "zone_id" {
  type    = string
  default = "foo"
}

variable "tgw_igw" {
  type    = bool
  default = true
}

variable "tgw_across_region" {
  type    = bool
  default = true
}

variable "tgw_inspect_all" {
  type    = bool
  default = false
}

variable "zone_enabled" {
  type    = bool
  default = true
}

variable "acm_enabled" {
  type    = bool
  default = true
}