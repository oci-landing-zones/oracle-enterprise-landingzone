##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

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
