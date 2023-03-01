terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# Create Internet Gateway
# -----------------------------------------------------------------------------
resource "oci_core_security_list" "test_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.security_list_display_name

  egress_security_rules {
    destination = var.security_list_egress_security_rules_destination
    protocol    = var.security_list_egress_security_rules_protocol
    description = var.security_list_egress_security_rules_description
    destination_type = var.security_list_egress_security_rules_destination_type
  }
  ingress_security_rules {
    #Required
    protocol = var.security_list_ingress_security_rules_protocol
    source = var.security_list_ingress_security_rules_source

    #Optional
    description = var.security_list_ingress_security_rules_description
    source_type = var.security_list_ingress_security_rules_source_type
  }
}  

