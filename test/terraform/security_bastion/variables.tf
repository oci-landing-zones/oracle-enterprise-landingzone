variable "compartment_replication_delay" {
  type         = string
  description  =  "delay to allow compartments to replicate"
  default      = "90s"
}

variable "compartment_ocid" {
  type        = string
  description = "the ocid of the compartment instances will live in. Defaults to tenancy root."
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
  default     = "TSTBAST"
}

variable "vcn_cidr_block" {
  type = string
  description = "Test VCN CIDR"
  default = "10.0.0.0/16"
}

variable "test_subnet_cidr_block" {
  type = string
  description = "Hub public subnet CIDR"
  default = "10.0.0.0/24"
}