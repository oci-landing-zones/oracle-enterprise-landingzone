##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "topic_id" {
  value       = oci_ons_notification_topic.topic_service.id
  description = "The OCID of the topic created"
}

output "subscription_id" {
  description = "The subscriptions, indexed by ID."
  value       = { for sub in oci_ons_subscription.subscription_service : sub.id => sub }
}
