locals {
  accounts_updated = {
    for key, value in var.accounts :
    key => merge(value, { parent = module.ous.ids[value.parent] })
    if value.parent != null
  }

}