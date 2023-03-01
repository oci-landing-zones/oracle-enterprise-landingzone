terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# Create Route Tables and Attachment
# -----------------------------------------------------------------------------
resource "oci_core_route_table" "route_table" {
  count          = var.is_default == false ? 1 : 0
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

resource "oci_core_route_table_attachment" "oci_core_route_table_attachment" {
  count            = var.subnet_name != "" ? 1 : 0
  #count           = var.is_default == false ? 1 : 0
  subnet_id      = var.subnet_id
  route_table_id = oci_core_route_table.route_table[0].id
}

# -----------------------------------------------------------------------------
# Create Default Route Table Public Subnet Route Table
# -----------------------------------------------------------------------------
/*
resource "oci_core_default_route_table" "defaultRouteTable" {
  count                      = var.is_default == true ? 1 : 0
  manage_default_resource_id = var.default_route_table_id
  dynamic "route_rules" {
    for_each = var.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}*/

