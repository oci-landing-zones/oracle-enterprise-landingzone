variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment containing the policy."
}

variable "description" {
  type        = string
  description = "The description of policy"
}

variable "policy_name" {
  type        = string
  description = "The name of policy."
}

variable "statements" {
  type        = list(string)
  description = "An array of policy statements written in the policy language."
}