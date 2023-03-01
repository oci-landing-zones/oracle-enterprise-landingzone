terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_ons_notification_topic" "topic_service" {
  compartment_id = var.compartment_id
  name           = var.topic_name
  description    = var.topic_description
}

resource "oci_ons_subscription" "subscription_service" {
  for_each       = toset(var.subscription_endpoint)
  compartment_id = var.compartment_id
  endpoint       = each.key
  protocol       = var.subscription_protocol
  topic_id       = oci_ons_notification_topic.topic_service.id
}

resource "oci_events_rule" "event_rule" {
  for_each       = var.event_rules
  compartment_id = var.compartment_id
  condition      = each.value.rule_condition
  display_name   = each.value.rule_display_name
  is_enabled     = each.value.rule_is_enabled
  description    = each.value.rule_description

  actions {
    actions {
      action_type = "ONS" #FAAS ONS OSS
      is_enabled  = true
      # function_id = oci_functions_function.test_function.id
      # stream_id   = oci_streaming_stream.test_stream.id
      topic_id = oci_ons_notification_topic.topic_service.id
    }
  }
}
