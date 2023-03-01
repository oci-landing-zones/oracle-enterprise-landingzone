variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the root compartment."
}

variable "is_onboarded" {
  type        = bool
  description = "Use true if tenancy is to be onboarded to logging analytics and false if tenancy is to be offboarded."
}

variable "resource_label" {
  type = string
}
