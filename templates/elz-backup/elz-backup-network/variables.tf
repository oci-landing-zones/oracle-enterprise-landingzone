variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}
variable "workload_compartment_id" {
  type        = string
  description = "WorkLoad Compartment OCID"
}

variable "spoke_vcn_cidr" {
  type        = string
  description = "Spoke:VCN CIDR Block."
}

variable "backup_region" {
  type        = string
  description = "Name of the backup region"
}

variable "tenancy_ocid" {
  type        = string
  description = "OCID of the home tenancy"
}