##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "break_glass_user_index" {
  type        = string
  description = "the index of the break glass user"
}

variable "break_glass_user_email" {
  type        = string
  description = "The email address of the break glass user"
}

variable "administrator_group_name" {
  type        = string
  description = "The name for the administrator group"
  default     = "Administrators"
}

