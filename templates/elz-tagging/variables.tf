##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "environment_compartment_id" {
  type        = string
  description = "The OCID of the compartment."
}

variable "environment_compartment_name" {
  type        = string
  description = "The OCID of the compartment."
}

variable "cost_center_tagging" {
  type        = string
  description = "Compartment Cost Center Tag."
}

variable "geo_location_tagging" {
  type        = string
  description = "Compartment Geo Location Tag."
}

variable "enable_tagging" {
  type        = bool
  description = "Set to true to enable Tagging."
}

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}
variable "tenancy_ocid" {
  type        = string
  description = "Set to true to enable Tagging."
}
variable "region" {
  type        = string
  description = "The OCI region"
}
variable "home_compartment_id" {
  type        = string
  description = "Home Compartment ID"
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
}

variable "resource_label" {
  type        = string
  description = "Prefix used to avoid naming conflict"
}