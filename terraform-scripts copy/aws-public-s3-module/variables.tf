variable "bucket_name" {
  type    = string
  default = "burak-terraform-test12"
}

variable "policy" {
  description = "Number of Policies to create"
  type        = set(string)
  default     = []

}