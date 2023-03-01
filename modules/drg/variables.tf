variable "compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
}

variable "drg_display_name" {
  description = "(Updatable) Name of Dynamic Routing Gateway. Does not have to be unique."
  type        = string
  validation {
    condition     = length(var.drg_display_name) > 0
    error_message = "The drg_display_name value cannot be an empty string."
  }
}

# @TODO add type definitions for maps/objects
variable "drg_vcn_attachments" {
  description = "The network resource attached to the DRG"
  type        = map(any)
  default     = null
}

variable "route_distribution_map" {
  type        = map(any)
  default     = null
  description = "The route table used by the DRG attachment."
}

variable "drg_route_table_map" {
  type        = map(any)
  default     = null
  description = "The route table used by the DRG attachment."
}
