terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# Create Service Gateway and Route Table
# -----------------------------------------------------------------------------
resource "oci_core_service_gateway" "sgw" {
  compartment_id = var.compartment_id
  display_name   = var.sgw_display_name
  vcn_id         = var.vcn_id 
  route_table_id = oci_core_route_table.route_table.id

  services {
    service_id = var.service_id#lookup(data.oci_core_services.service_gateway_all_oci_services.services[0], "id")
  }
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.route_table_display_name

  dynamic "route_rules" {
    for_each = var.route_rules
    content {
      description       = var.route_table_display_name
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}
