terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_objectstorage_bucket" "bucket" {
  compartment_id = var.compartment_id
  name           = var.name
  namespace      = var.namespace
  access_type    = "NoPublicAccess"
  kms_key_id     = var.kms_key_id
  storage_tier   = var.storage_tier

  retention_rules {
    display_name = var.retention_rule_display_name

    duration {
      time_amount = var.retention_policy_duration_amount
      time_unit   = var.retention_policy_duration_time_unit
    }
  }
  lifecycle {
    ignore_changes = all
  }
}
