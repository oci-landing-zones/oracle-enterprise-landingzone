##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "group_names" {
  type        = list(string)
  description = "The list of user group names."
}

variable "identity_domain_id" {
  type        = string
  description = "the OCID of identity domain"
}