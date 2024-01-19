##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "logging_compartment_id" {
  type        = string
  description = "the ocid of logging compartment"
}
variable "home_compartment_name" {
  type        = string
  description = "The name of the Landing Zone home compartment."
}
