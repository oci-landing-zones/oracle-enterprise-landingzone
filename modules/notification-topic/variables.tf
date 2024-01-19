##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment to create the topic in."
}

variable "topic_name" {
  type        = string
  description = "The name of the topic being created."
}

variable "topic_description" {
  type        = string
  description = "The description of the topic being created"
}

variable "subscription_endpoint" {
  type         = list(string)
  description = "A locator that corresponds to the subscription protocol."
}

variable "subscription_protocol" {
  type        = string
  description = "Valid values: CUSTOM_HTTPS, EMAIL, ORACLE_FUNCTIONS, PAGERDUTY, SLACK, SMS"
}

variable "event_rules" {
  type        = map(any)
  default     = {}
  description = ""
}
