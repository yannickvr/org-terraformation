# org-terraformation

`JBOT - Just a Bunch Of Terraform. But to manage your AWS organization`

This is a (hobby) attempt to create the features that the AWSome [org-formation](https://github.com/org-formation/org-formation-cli) has, but natively in Terraform. 

Features:

- Create AWS Organization
- Create Organizational units
    - Add parent Organizational Units (Max 5 levels deep!)
    - Attach Organization Policies
- Create Organization member accounts
    - Add member accounts to organizational units
    - Attach Organization Policies
- Configure delegated administrators
- Configure enabled policy types
- Create Organization Policies
    - Defaults to Service Control Policies

Wishlist: 

- An analogue for `org-formation init` which imports the organization
- [AWS Account contact information](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact)
- [AWS Service Quota, ie. max accounts in the org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_service_quota)
- More docs and examples

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
| [aws_organizations_delegated_administrator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.fifth_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.first_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.fourth_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.second_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.third_level_ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts"></a> [accounts](#input\_accounts) | A map of accounts. The key is used for the account name | <pre>map(object({<br>    email                      = string<br>    tags                       = optional(map(string), null)<br>    iam_user_access_to_billing = optional(string, null)<br>    parent                     = optional(string, "root")<br>    policies                   = optional(list(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_aws_service_access_principals"></a> [aws\_service\_access\_principals](#input\_aws\_service\_access\_principals) | List of trusted service access principals | `list(any)` | `[]` | no |
| <a name="input_delegated_administrators"></a> [delegated\_administrators](#input\_delegated\_administrators) | Used to delegate administration of a service for the whole organization. ie. securityhub | <pre>map(object({<br>    account = string<br>  }))</pre> | `{}` | no |
| <a name="input_enabled_policy_types"></a> [enabled\_policy\_types](#input\_enabled\_policy\_types) | Which policy types to enable for the organization. See https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnablePolicyType.html | `list(string)` | `[]` | no |
| <a name="input_feature_set"></a> [feature\_set](#input\_feature\_set) | Enable all features for the organization | `string` | `"ALL"` | no |
| <a name="input_ous"></a> [ous](#input\_ous) | A map of the organizational units. The key is used for the OU name | <pre>map(object({<br>    parent   = optional(string, "")<br>    tags     = optional(map(string))<br>    policies = optional(list(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Organization policies | <pre>map(object({<br>    content     = string<br>    description = optional(string, null)<br>    type        = optional(string, null)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | Account names and account IDs |
| <a name="output_ous"></a> [ous](#output\_ous) | Organizational units and OU Ids |