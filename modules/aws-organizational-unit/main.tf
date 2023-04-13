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