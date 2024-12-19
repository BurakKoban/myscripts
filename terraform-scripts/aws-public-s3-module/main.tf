module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = var.bucket_name
  #policy = data.aws_iam_policy_document.bucket_policy.json
  #policy = file("./s3_bucket_policy.json")
  attach_deny_insecure_transport_policy = true

}

