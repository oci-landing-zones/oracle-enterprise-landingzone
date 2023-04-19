terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# DRG VCN ATTACHMENT
# ----------------------------------------------------------------------------- 

resource "oci_core_drg_attachment" "drg_attachment" {
    drg_id = var.drg_id
    network_details {
        id              = var.vcn_id
        type            = var.drg_attachment_type
        vcn_route_type  = var.drg_attachment_vcn_route_type
    }
}
