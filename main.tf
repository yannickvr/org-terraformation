resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = var.feature_set
  enabled_policy_types          = var.enabled_policy_types
}

resource "aws_organizations_account" "account" {
  for_each                   = local.accounts_updated
  name                       = each.key
  email                      = each.value.email
  tags                       = each.value.tags
  iam_user_access_to_billing = each.value.iam_user_access_to_billing
  parent_id                  = each.value.parent
}

resource "aws_organizations_policy" "this" {
  for_each    = var.policies
  name        = each.key
  content     = each.value.content
  description = each.value.description
  type        = each.value.type
}

resource "aws_organizations_policy_attachment" "account" {
  for_each  = { for attachment in local.account_policy_attachments : "${attachment.policy}.${attachment.target}" => attachment }
  policy_id = aws_organizations_policy.this[each.value.policy].id
  target_id = aws_organizations_account.account[each.value.target].id
}

resource "aws_organizations_policy_attachment" "ou" {
  for_each  = { for attachment in local.ou_policy_attachments : "${attachment.policy}.${attachment.target}" => attachment }
  policy_id = aws_organizations_policy.this[each.value.policy].id
  target_id = local.ous[each.value.target]
}

resource "aws_organizations_delegated_administrator" "this" {
  for_each          = var.delegated_administrators
  account_id        = aws_organizations_account.account[each.value.account].id
  service_principal = "${each.key}.amazonaws.com"
}

resource "aws_organizations_organizational_unit" "first_level_ou" {
  for_each  = local.first_level_ous
  name      = each.key
  parent_id = each.value.parent
  tags      = each.value.tags
}

resource "aws_organizations_organizational_unit" "second_level_ou" {
  for_each  = local.second_level_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.first_level_ou[each.value.parent].id
  tags      = each.value.tags
}

resource "aws_organizations_organizational_unit" "third_level_ou" {
  for_each  = local.third_level_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.second_level_ou[each.value.parent].id
  tags      = each.value.tags
}

resource "aws_organizations_organizational_unit" "fourth_level_ou" {
  for_each  = local.fourth_level_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.third_level_ou[each.value.parent].id
  tags      = each.value.tags
}

resource "aws_organizations_organizational_unit" "fifth_level_ou" {
  for_each  = local.fifth_level_ous
  name      = each.key
  parent_id = aws_organizations_organizational_unit.fourth_level_ou[each.value.parent].id
  tags      = each.value.tags
}

