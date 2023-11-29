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
# Create NAT Gateway
# -----------------------------------------------------------------------------
resource "oci_core_nat_gateway" "OCI-ELZ-NGW-P-HUB" {
  compartment_id = var.network_compartment_id
  vcn_id = var.vcn_id
  display_name = var.nat_gateway_display_name
}

