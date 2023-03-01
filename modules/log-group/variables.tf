variable "compartment_id" {
  type        = string
  description = " The OCID of the compartment that the resource belongs to."
}

variable "display_name" {
  type        = string
  description = "The display name of log group"
}

variable "description" {
  type        = string
  description = "Description for log group"
}