variable "network_compartment_id" {
  type        = string
  description = "The OCID of the compartment to contain the VCN."
}

variable "vcn_id" {
  type        = string
  description = "The VCN OCID Value"
}

variable "service_gateway_display_name" {
  type        = string
  description = "Service Gateway Display Name."
}