variable "compartment_parent_id" {
  type        = string
  description = "OCID of the parent compartment."
}

variable "compartment_name" {
  type        = string
  description = "Name of the compartment to create."
}

variable "compartment_description" {
  type        = string
  description = "Description of the compartment to create."
}

variable "enable_compartment_delete" {
  type        = bool
  description = "Allows the compartment to delete on terraform destroy."
  default = false
}

variable "compartment_replication_delay" {
  type         = string
  description  =  "delay to allow compartments to replicate"
  default      = "90s"
}