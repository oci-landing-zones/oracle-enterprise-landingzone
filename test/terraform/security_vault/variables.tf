variable "compartment_replication_delay" {
  type         = string
  description  =  "delay to allow compartments to replicate"
  default      = "90s"
}

variable "compartment_ocid" {
  type        = string
  description = "the ocid of the compartment test resources will live in. Defaults to tenancy root."
  default = ""
}

variable "environment_prefix" {
  type = string
  description = "1 char env prefix"
  default = "P"
}

variable "resource_label" {
  type        = string
  description = "Prefix used to avoid naming conflict"
  default     = "TSTCG"
}
