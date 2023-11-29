##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

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
