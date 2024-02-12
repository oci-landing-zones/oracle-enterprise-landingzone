##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the root compartment."
}

variable "is_onboarded" {
  type        = bool
  description = "Use true if tenancy is to be onboarded to logging analytics and false if tenancy is to be offboarded."
}

variable "resource_label" {
  type = string
}
