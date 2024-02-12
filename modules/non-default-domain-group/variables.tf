##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "group_display_name" {
  type        = string
  description = "Identity Group Display Name."
}

variable "idcs_endpoint" {
  type        = string
  description = "The basic endpoint for the identity domain."
}