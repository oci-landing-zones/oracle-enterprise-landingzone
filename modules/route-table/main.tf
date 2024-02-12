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

######################################################################
#                      Create Route Table                            #
######################################################################
resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.route_table_display_name
  dynamic "route_rules" {
    for_each = var.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}
