##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}
variable "name" {
  type        = string
  description = "The name of the bucket. Must be unique within an Object Storage namespace. "
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment in which to create the bucket."
}

variable "kms_key_id" {
  type        = string
  description = "The OCID of a master encryption key."
}

variable "storage_tier" {
  type        = string
  description = "The type of storage tier of this bucket. "
}

variable "retention_rule_display_name" {
  type        = string
  description = "The display name of retention rule"
}

variable "retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter."
}

variable "retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
}

variable "namespace" {
  type        = string
  description = "The namespace of object storage bucket"
}