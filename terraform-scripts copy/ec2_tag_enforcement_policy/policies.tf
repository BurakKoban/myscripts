data "aws_iam_policy_document" "scp_policy" {
# Deny EC2 instances without mandatory tags
dynamic "statement" {
    for_each = var.ec2_tag_enforcement
    content {
      effect = "Deny"
      actions = [
        "ec2:RunInstances"
      ]
      resources = ["arn:aws:ec2:*:*:instance/*"]
      condition {
        test     = "Null"
        variable = statement.value
        values = ["true"]
    }
  }
}


dynamic "statement" {
    for_each = var.ec2_tag_enforcement
    content {
      effect = "Deny"
      actions = [
        "ec2:DeleteTags"
      ]
      resources = ["arn:aws:ec2:*:*:instance/*"]
      condition {
        test     = "Null"
        variable = statement.value
        values = ["false"]
    }
  }
}

}