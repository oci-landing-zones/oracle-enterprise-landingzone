##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment where you want to create the master encryption key."
}

variable "display_name" {
  type        = string
  description = "The display name of key"
}

variable "shape_algorithm" {
  type        = string
  description = "The algorithm used by a key's key versions to encrypt or decrypt."
}

variable "shape_length" {
  type        = number
  description = "The length of the key in bytes, expressed as an integer."
}

variable "management_endpoint" {
  type        = string
  description = "The service endpoint to perform management operations against."
}

variable "protection_mode" {
  type        = string
  description = "he key's protection mode indicates how the key persists and where cryptographic operations that use the key are performed."
}