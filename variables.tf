variable "ous" {
  type = map(object({
    parent = optional(string),
    tags   = optional(map(string))
  }))
  default = {}
}

variable "accounts" {
  type = map(object({
    email  = string,
    parent = optional(string, "root"),
    tags   = optional(map(string))
  }))
  default = {}
}

variable "aws_service_access_principals" {
  type = list(any)
  default = [
    "cloudtrail.amazonaws.com",
    "inspector2.amazonaws.com",
    "securityhub.amazonaws.com",
    "sso.amazonaws.com",
  ]
}

variable "feature_set" {
  type    = string
  default = "ALL"
}