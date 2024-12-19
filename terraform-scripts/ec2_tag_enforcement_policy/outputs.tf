# Generated collection of SCP statements
output "scp_document" {
  description = "Generated SCP document"
  value       = data.aws_iam_policy_document.scp_policy.json
}

output "the_name_of_the_scp" {
  description = "Name of the SCP"
  value       = local.name
}

output "root_ou" {
  description = "The Root OU"
  value       = data.aws_organizations_organizational_units.root
}

output "sub_ous" {
  description = "ARN, ID and Name of the Child OUs"
  value       = data.aws_organizations_organizational_units.sub_ous
}

# output "namespace" {
#   description = "Namespace of the SCP"
#   value       = local.namespace
# }
# 
# output "stage" {
#   description = "Stage of the SCP"
#   value       = local.stage
# }