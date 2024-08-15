module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket = "burak-terraform-test12"
  # policy = file("./s3_bucket_policy.json")
  attach_deny_insecure_transport_policy = true

}

