##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "prod_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "prod_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "nonprod_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "nonprod_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "archive_log_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "archive_log_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}
variable "archive_external_master_encryption_key" {
  type        = string
  description = "OCID of existing key to use (instead of creating a new MEK)"
  default     = ""
}