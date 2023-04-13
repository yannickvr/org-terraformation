locals {
  root_ou = {
    root = var.root_ou_id
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
}

output "ids" {
  value = merge(local.root_ou, local.accounts_first, local.accounts_second, local.accounts_third, local.accounts_fourth, local.accounts_fifth)
}