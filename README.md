# org-terraformation

`JBOT - Just a Bunch Of Terraform. But to manage your AWS organization`

This is a (hobby) attempt to create the features that the AWSome [org-formation](https://github.com/org-formation/org-formation-cli) has, but natively in Terraform. 

Wishlist: 

- An analogue for `org-formation init` which imports the organization
- Service Control policies
- Bunch of other stuff

# Usage

Read up on how to install and use terraform for yourself first. Installation, deployment and state management are all context dependent

See `_example` for example usage as a module

## Import Existing Resources

### Organization

Make sure your AWS CLI profile is active for the management account

- Run `terraform init`
- Run `terraform import aws_organizations_organization.org o-fx0z31337` (Enter your own organization ID)
- Run `terraform plan`
- Review if there are changes, add changes to the relevant variable
- Run `terraform plan` - should say `No Changes.`

### AWS Accounts

Start off by importing the management account

- Enter the email and account name for the management account in the `accounts` variable
- Run `terraform import aws_organizations_account.account[\"management\"] 111111111111` (enter the AWS account ID for your management account)
- Run `terraform plan`
- Review if there are changes, add changes to the `accounts` variable
- Run `terraform plan` - should say `No Changes.`
- Repeat for all existing accounts or add new accounts
- If the plan requires an OU Id, import `Organizational Units` first

### Organizational Units

This assumes you're familiar with importing now.

- Add your ous to the `ous` variable
- Run e.g. `terraform import ous.aws_organizations_organizational_unit.first_level_ou[\"my-ou"] ou-7hga-gvgt31337`
- Repeat for all OUs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.fifth_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.first_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.fourth_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.second_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.third_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts"></a> [accounts](#input\_accounts) | n/a | <pre>map(object({<br>    email                      = string<br>    tags                       = optional(map(string), null)<br>    iam_user_access_to_billing = optional(string, null)<br>    parent                     = optional(string, "root")<br>  }))</pre> | n/a | yes |
| <a name="input_aws_service_access_principals"></a> [aws\_service\_access\_principals](#input\_aws\_service\_access\_principals) | n/a | `list(any)` | <pre>[<br>  "cloudtrail.amazonaws.com",<br>  "inspector2.amazonaws.com",<br>  "securityhub.amazonaws.com",<br>  "sso.amazonaws.com"<br>]</pre> | no |
| <a name="input_feature_set"></a> [feature\_set](#input\_feature\_set) | n/a | `string` | `"ALL"` | no |
| <a name="input_ous"></a> [ous](#input\_ous) | n/a | <pre>map(object({<br>    parent = optional(string, "")<br>    tags   = optional(map(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | n/a |
| <a name="output_ous"></a> [ous](#output\_ous) | n/a |