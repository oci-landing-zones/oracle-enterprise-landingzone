##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of the tenancy."
}

variable "name" {
  type        = string
  description = "The name you assign to the group during creation. The name must be unique across all compartments in the tenancy. "
}

variable "description" {
  type        = string
  description = "The description you assign to the Group. Does not have to be unique, and it's changeable. "
}

variable "matching_rule" {
  type        = string
  description = "Define a matching rule or a set of matching rules to define the group members."
}