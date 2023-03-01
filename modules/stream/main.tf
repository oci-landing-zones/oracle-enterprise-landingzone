terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_streaming_stream_pool" "stream_pool" {
  compartment_id = var.compartment_id
  name           = var.stream_pool_name

#  custom_encryption_key {
#    kms_key_id = var.kms_key_id
#  }
}

resource "oci_streaming_stream" "stream" {
  name           = var.stream_name
  partitions     = var.stream_partitions
  stream_pool_id = oci_streaming_stream_pool.stream_pool.id
}

resource "oci_events_rule" "rule" {
  actions {
    actions {
      action_type = var.rule_action_type
      is_enabled  = var.rule_action_is_enabled

      stream_id = oci_streaming_stream.stream.id
    }
  }
  compartment_id = var.compartment_id
  condition      = var.rule_condition
  display_name   = var.rule_display_name
  is_enabled     = var.rule_is_enabled
}
