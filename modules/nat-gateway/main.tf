terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# Create NAT Gateway
# -----------------------------------------------------------------------------
resource "oci_core_nat_gateway" "OCI-ELZ-NGW-P-HUB" {
  compartment_id = var.network_compartment_id
  vcn_id = var.vcn_id
  display_name = var.nat_gateway_display_name
}

