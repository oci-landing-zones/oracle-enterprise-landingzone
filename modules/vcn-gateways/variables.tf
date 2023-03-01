variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment to contain the service gateway."
}

variable "sgw_display_name" {
  type        = string
  description = "The display name of service gateway"
}

variable "vcn_id" {
  type        = string
  description = "The OCID of the VCN"
}

variable "service_id" {
  type        = string
  description = "The OCID of the Service."
}

variable "route_table_display_name" {
  type        = string
  description = "The display name of route table."
}

variable "route_rules" {
  type        = map(any)
  description = "Route Rules."
}
