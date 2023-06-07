# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

###########

variable "network_compartment_id" {
  type        = string
  description = "Network Compartment OCID"
}

variable "hub_vcn_cidr_block" {
  type        = string
  description = "Hub VCN CIDR Block."
}

variable "network_firewall_subnet_id" {
  type        = string
  description = "OCID of subnet to create network FW on." 
}
