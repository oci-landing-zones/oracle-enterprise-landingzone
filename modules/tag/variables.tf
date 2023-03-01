variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment."
}

variable "tag_namespace_description" {
  type        = string
  description = "The description of the tag namespace."
}

variable "tag_namespace_name" {
  type        = string
  description = "The name of the tag namespace"
}

variable "is_namespace_retired" {
  type        = bool
  default     = false
  description = "Whether the tag namespace is retired."
}

variable "tag_map" {

}

variable "tag_default_map" {

}
