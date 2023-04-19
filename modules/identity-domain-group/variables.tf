variable "group_names" {
  type        = list(string)
  description = "The list of user group names."
}

variable "identity_domain_id" {
  type        = string
  description = "the OCID of identity domain"
}