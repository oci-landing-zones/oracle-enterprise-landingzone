##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where you want to create the announcement subscription"
}

variable "subscription_display_name" {
  type        = string
  description = "The display name of the subscription"
}

variable "notification_topic_id" {
  type        = string
  description = "The OCID of the Notifications service topic"
}

variable "filter_groups" {
  type        = map(any)
  description = "A list of filter groups for the announcement subscription. "
}
