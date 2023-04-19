variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment to contain the route table."
}

variable "vcn_id" {
  type        = string
  description = "The OCID of the VCN the route table belongs to."
}

variable "route_table_display_name" {
  type        = string
  description = "The display name of route table"
}

variable "route_rules" {
  type        = map(any)
  description = "The collection of rules for routing destination IPs to network devices."
}
