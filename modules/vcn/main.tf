terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

######################################################################
#                      Create VCN                                    # 
######################################################################
resource "oci_core_vcn" "vcn" {
  cidr_blocks    = var.vcn_cidrs[*]
  compartment_id = var.compartment_ocid_id
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
  is_ipv6enabled = var.enable_ipv6
}

resource "oci_core_default_security_list" "spoke_default_security_list_locked_down" {
  manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id
}
