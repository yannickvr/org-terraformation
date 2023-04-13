resource "aws_organizations_account" "account" {
  for_each                   = var.accounts
  name                       = each.key
  email                      = each.value.email
  tags                       = each.value.tags
  iam_user_access_to_billing = each.value.iam_user_access_to_billing
  parent_id                  = each.value.parent
}