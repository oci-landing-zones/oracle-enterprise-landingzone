##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "drg_id" {
  type        = string
  description = "DRG OCID Value."
}

variable "vcn_id" {
  type        = string
  description = "VCN OCID Value"
}

variable "drg_attachment_type" {
  type        = string
  description = "DRG Attacment Network Type"
}

variable "drg_attachment_vcn_route_type" {
  type        = string
  description = "DRG Attacment Network VCN Route Type"
}
