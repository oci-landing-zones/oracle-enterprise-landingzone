#variable "compartment_id" {
#  type        = string
#  description = "The OCID of the compartment to contain the VCN."
#}

variable "vcn_cidr_block" {
  type        = string
  description = "The CIDR block of VCN"
}

variable "vcn_display_name" {
  type        = string
  description = "The display name of VCN"
}

variable "vcn_dns_label" {
  type        = string
  description = "The DNS label of VCN"
}

variable "enable_ipv6" {
  type        = bool
  default     = false
  description = "Compartment : Option to enable ipv6"
}
variable "network_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created."
}

