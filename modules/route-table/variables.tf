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

variable "subnet_id" {
  type        = string
  description = "The OCID of the subnet."
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = ""
}


variable "is_default" {
  type        = bool
  default     = false
  description = "Option use default route table"
}

variable "default_route_table_id" {
  type    = string
  default = "The OCID of default route table"
}
