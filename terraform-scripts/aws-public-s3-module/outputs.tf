output "s3_bucket_name" {
  value       = module.s3-bucket.s3_bucket_id
  description = "S3 Bucket name"
}