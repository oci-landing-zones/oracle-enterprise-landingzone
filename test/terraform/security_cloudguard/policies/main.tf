terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_identity_policy" "policy" {
  compartment_id = var.compartment_ocid
  description    = var.description
  name           = var.policy_name
  statements     = var.statements
}

resource "time_sleep" "policy_propagation_delay" {
  depends_on      = [oci_identity_policy.policy]
  create_duration = "90s"
}
