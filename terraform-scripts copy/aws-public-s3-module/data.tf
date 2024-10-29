# data "aws_iam_policy_document" "bucket_policy" {
#   # Deny EC2 instances without mandatory tags
#   dynamic "statement" {
#     for_each = var.policy
#     content {
#       effect = "Deny"
#       actions = [
#         "s3:*"
#       ]
#       resources = [
#         "arn:aws:s3:::var.bucket_name/*",
#         "arn:aws:s3:::var.bucket_name"
#       ]
#       condition {
#         test     = "Bool"
#         variable = "aws:SecureTransport"
#         values   = ["false"]
#       }
#     }
#   }
# }