variable "ous" {
  type = map(object({
    parent = optional(string, "")
    tags   = optional(map(string), null)
  }))
}

variable "root_ou_id" {}