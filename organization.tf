resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.aws_service_access_principals
  feature_set                   = var.feature_set
}

module "accounts" {
  source   = "./modules/aws-account"
  accounts = local.accounts_updated
}

module "ous" {
  source     = "./modules/aws-organizational-unit"
  root_ou_id = aws_organizations_organization.org.roots[0].id
  ous        = var.ous
}