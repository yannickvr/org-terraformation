variable "ous" {
  type = map(object({
    parent   = optional(string, "")
    tags     = optional(map(string))
    policies = optional(list(string), null)
  }))
  default     = {}
  description = "A map of the organizational units. The key is used for the OU name"
}

variable "accounts" {
  type = map(object({
    email                      = string
    tags                       = optional(map(string), null)
    iam_user_access_to_billing = optional(string, null)
    parent                     = optional(string, "root")
    policies                   = optional(list(string), null)
  }))
  description = "A map of accounts. The key is used for the account name"
  default     = {}
}

variable "policies" {
  type = map(object({
    content     = string
    description = optional(string, null)
    type        = optional(string, null)
  }))
  description = "Organization policies"
  default     = {}
}

variable "aws_service_access_principals" {
  type        = list(any)
  default     = []
  description = "List of trusted service access principals"
}

variable "feature_set" {
  type        = string
  default     = "ALL"
  description = "Enable all features for the organization"
}

variable "enabled_policy_types" {
  type        = list(string)
  default     = []
  description = "Which policy types to enable for the organization. See https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnablePolicyType.html"
}

variable "delegated_administrators" {
  type = map(object({
    account = string
  }))
  description = "Used to delegate administration of a service for the whole organization. ie. securityhub"
  default     = {}
}