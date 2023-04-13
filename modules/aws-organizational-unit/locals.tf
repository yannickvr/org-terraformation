locals {
  first_level_ous = { for key, value in var.ous :
    key => merge(value, { parent = var.root_ou_id })
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

}