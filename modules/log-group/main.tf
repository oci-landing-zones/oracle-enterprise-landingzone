terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_logging_log_group" "log_group" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  description    = var.description
}
