##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_monitoring_alarm" "monitoring_alarm" {
  for_each              = var.alarm_map
  compartment_id        = var.compartment_id
  destinations          = [var.notification_topic_id]
  display_name          = each.value.display_name
  is_enabled            = var.is_enabled
  metric_compartment_id = each.value.metric_compartment_id
  namespace             = each.value.namespace
  query                 = each.value.query
  severity              = each.value.severity

  message_format        = var.message_format
  pending_duration      = var.pending_duration
  metric_compartment_id_in_subtree = var.metric_compartment_id_in_subtree
}
