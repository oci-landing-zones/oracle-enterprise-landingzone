##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "tenancy_ocid" {
  type = string
}

variable "compartment_id" {
  type        = string
  description = "The id of the compartment to place the resources."
}

variable "log_group_display_name" {
  type        = string
  description = "The display name of log group"
}

variable "log_group_description" {
  type        = string
  description = "The description of log group"
}

variable "service_connector_display_name" {
  type        = string
  description = "The display name of the logging analytics service connector"
}

variable "service_connector_source_compartment_id" {
  type        = string
  description = "The compartment of the source log group for the logging analytics service connector"
}

variable "service_connector_source_log_group_id" {
  type        = string
  description = "The log group id for the logging analytics service connector"
}

variable "service_connector_source_kind" {
  type        = string
  description = "The kind of log source for the logging analytics service connector"
}
