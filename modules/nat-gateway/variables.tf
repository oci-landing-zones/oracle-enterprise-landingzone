##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "network_compartment_id" {
  type        = string
  description = "The OCID of the compartment to contain the VCN."
}

variable "vcn_id" {
  type        = string
  description = "The VCN OCID Value"
}

variable "nat_gateway_display_name" {
  type        = string
  description = "NAT Gateway Display Name."
}