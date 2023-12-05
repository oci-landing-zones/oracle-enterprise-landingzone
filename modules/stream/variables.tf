##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment that contains the stream."
}

variable "stream_pool_name" {
  type        = string
  description = "The name of stream pool"
}

variable "kms_key_id" {
  type        = string
  description = "Custom Encryption Key (Master Key) ocid."
}

variable "stream_name" {
  type        = string
  description = "The name of the stream."
}

variable "stream_partitions" {
  type        = number
  description = "The number of partitions in the stream."
}

variable "rule_action_type" {
  type        = string
  description = "The action to perform if the condition in the rule matches an event.(ONS, OSS, FAAS)"
}

variable "rule_action_is_enabled" {
  type        = bool
  description = "Option to enable rule action"
}

variable "rule_condition" {
  type        = string
  description = "A filter that specifies the event that will trigger actions associated with this rule."
}

variable "rule_display_name" {
  type        = string
  description = "The display name of the rule"
}

variable "rule_is_enabled" {
  type        = bool
  description = "Option to enable rule"
}



