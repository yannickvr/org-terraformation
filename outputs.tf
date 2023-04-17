output "accounts" {
  value = {
    for k, v in aws_organizations_account.account : k => v.id
  }
  description = "Account names and account IDs"
}

output "ous" {
  value = local.ous
  description = "Organizational units and OU Ids"
}