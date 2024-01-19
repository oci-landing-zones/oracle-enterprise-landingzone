##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "home_compartment_id" {
  type        = string
  description = "Home Compartment ID"
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
}
# -----------------------------------------------------------------------------
# 
# -----------------------------------------------------------------------------
variable "budget_compartment_id" {
  type        = string
  description = "The ocid of compartment to provision resources"
}

variable "budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  type        = string
}

variable "budget_description" {

  type = string
}

variable "budget_display_name" {

  type = string
}

variable "budget_target" {
  description = "The compartment ocid for the budget"
  type        = string
}

# -----------------------------------------------------------------------------
# Optional inputs and values to override
# -----------------------------------------------------------------------------
variable "budget_alert_rule_threshold" {
  description = "The target for the budget"
  type        = string
}

variable "budget_alert_rule_message" {
  description = "The alert message for budget alerts."
  type        = string
}

variable "budget_alert_rule_recipients" {
  description = "The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon"
  type        = string
}
