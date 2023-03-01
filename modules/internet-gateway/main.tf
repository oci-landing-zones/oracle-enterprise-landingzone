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
resource "oci_core_internet_gateway" "OCI-ELZ-IGW-P-HUB" {
  compartment_id = var.network_compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.internet_gateway_display_name
}

