locals {
  ous = merge(local.root_ou, local.accounts_first, local.accounts_second, local.accounts_third, local.accounts_fourth, local.accounts_fifth)
  accounts_updated = {
    for key, value in var.accounts :
    key => merge(value, { parent = local.ous[value.parent] })
    if value.parent != null
  }

  first_level_ous = { for key, value in var.ous :
    key => merge(value, { parent = aws_organizations_organization.org.roots[0].id })
    if value.parent == "" || value.parent == null
  }

  second_level_ous = { for key, value in var.ous :
    key => merge(value, { parent = value.parent })
    if contains(keys(local.first_level_ous), value.parent)
  }

  third_level_ous = { for key, value in var.ous :
    key => merge(value, { parent = value.parent })
    if contains(keys(local.second_level_ous), value.parent)
  }

  fourth_level_ous = { for key, value in var.ous :
    key => merge(value, { parent = value.parent })
    if contains(keys(local.third_level_ous), value.parent)
  }

  fifth_level_ous = { for key, value in var.ous :
    key => merge(value, { parent = value.parent })
    if contains(keys(local.fourth_level_ous), value.parent)
  }

  root_ou = {
    root = aws_organizations_organization.org.roots[0].id
  }

  accounts_first = {
    for k, v in aws_organizations_organizational_unit.first_level_ou : k => v.id
  }
  accounts_second = {
    for k, v in aws_organizations_organizational_unit.second_level_ou : k => v.id
  }
  accounts_third = {
    for k, v in aws_organizations_organizational_unit.third_level_ou : k => v.id
  }
  accounts_fourth = {
    for k, v in aws_organizations_organizational_unit.fourth_level_ou : k => v.id
  }
  accounts_fifth = {
    for k, v in aws_organizations_organizational_unit.fifth_level_ou : k => v.id
  }

  account_policy_attachments = flatten(
    [
      for key, value in var.accounts : [
        for attachment in value.policies : {
          target = key
          policy = attachment
        }
      ]
      if value.policies != null
    ]
  )

  ou_policy_attachments = flatten(
    [
      for key, value in var.ous : [
        for attachment in value.policies : {
          target = key
          policy = attachment
        }
      ]
      if value.policies != null
    ]
  )

}