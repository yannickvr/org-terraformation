variable "accounts" {
  type = map(object({
    email                      = string
    tags                       = optional(map(string), null)
    iam_user_access_to_billing = optional(string, null)
    parent                     = optional(string, null)
  }))
}