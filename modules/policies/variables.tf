##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment containing the policy."
}

variable "description" {
  type        = string
  description = "The description of policy"
}

variable "policy_name" {
  type        = string
  description = "The name of policy."
}

variable "statements" {
  type        = list(string)
  description = "An array of policy statements written in the policy language."
}