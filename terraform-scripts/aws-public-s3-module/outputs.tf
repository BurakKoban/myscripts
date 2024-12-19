output "s3_bucket_name" {
  value       = module.s3-bucket.s3_bucket_id
  description = "S3 Bucket name"
}

# output "s3_bucket_policy" {
#   value       = data.aws_iam_policy_document.bucket_policy.json
#   description = "S3 Bucket policy"
# }