variable "default_profile" {
  type = string
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "targets" {
  description = "Lits of OU and account id's to attach SCP"
  type        = set(string)
  default     = []
}

variable "ec2_tag_enforcement" {
  description = "Deny creating EC2 instances without mandatory tags"
  default     = []
  type        = set(string)
}