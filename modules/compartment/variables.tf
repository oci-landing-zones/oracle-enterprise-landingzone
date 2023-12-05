##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "compartment_parent_id" {
  type        = string
  description = "OCID of the parent compartment."
}

variable "compartment_name" {
  type        = string
  description = "Name of the compartment to create."
}

variable "compartment_description" {
  type        = string
  description = "Description of the compartment to create."
}

variable "enable_compartment_delete" {
  type        = bool
  description = "Allows the compartment to delete on terraform destroy."
}
