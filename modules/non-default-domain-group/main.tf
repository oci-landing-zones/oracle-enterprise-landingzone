terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_identity_domains_group" "test_group" {

  display_name  = var.group_display_name
  idcs_endpoint = var.idcs_endpoint
  schemas       = ["urn:ietf:params:scim:schemas:core:2.0:Group"]

  lifecycle {
    ignore_changes = [ idcs_endpoint 
    ]
  }
}

