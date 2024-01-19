##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "log_display_name" {
  type        = string
  description = "The display name of service log"
}

variable "log_type" {
  type        = string
  description = "The logType that the log object is for, whether custom or service."
}

variable "log_group_id" {
  type        = string
  description = "The OCID of a log group to work with."
}

variable "log_source_category" {
  type        = string
  description = "Log object category."
}

variable "log_source_service" {
  type        = string
  description = "Service generating log."
}

variable "log_source_type" {
  type        = string
  description = "The log source type."
}
variable "log_source_resource" {
  type        = string
  description = "The unique identifier of the resource emitting the log."
}