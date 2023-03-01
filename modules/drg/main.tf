# Reference: https://github.com/oracle-terraform-modules/terraform-oci-drg

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# Create Dynamic Routing Gateway and Attachments
# -----------------------------------------------------------------------------
locals {
  drg_attachment_defaults = {
    route_table_id                               = null
    type                                         = "VCN"
    export_drg_route_distribution_id             = null
    remove_export_drg_route_distribution_trigger = false
  }

  drg_attachments_normalized = {
    for k, v in var.drg_vcn_attachments :
    k => merge(local.drg_attachment_defaults, v)
  }
}

resource "oci_core_drg" "drg" {
  compartment_id = var.compartment_id
  display_name   = var.drg_display_name
}

resource "oci_core_drg_attachment" "drg_vcn_attachment" {
  for_each     = local.drg_attachments_normalized
  drg_id       = oci_core_drg.drg.id
  display_name = each.value.display_name

  network_details {
    id             = each.value.vcn_id
    route_table_id = each.value.route_table_id
    type           = each.value.type
  }

  drg_route_table_id = each.value.drg_route_table_name != null ? oci_core_drg_route_table.route_table[each.value.drg_route_table_name].id : null
}

# -----------------------------------------------------------------------------
# Create Import Hub Distribution
# -----------------------------------------------------------------------------
locals {
  distribution_statements = merge(
    flatten([
      for k, v in var.route_distribution_map : {
        for k2, v2 in v.statements : k2 => {
          drg_route_distribution_id = oci_core_drg_route_distribution.route_distribution[k].id
          action                    = v2.action
          match_type                = v2.match_type
          attachment_type           = v2.attachment_type
          drg_attachment_name       = v2.drg_attachment_name
          priority                  = v2.priority
        }
  }])...)
}

resource "oci_core_drg_route_distribution" "route_distribution" {
  for_each          = var.route_distribution_map
  distribution_type = each.value.distribution_type
  drg_id            = oci_core_drg.drg.id
  display_name      = each.value.distribution_display_name
}

resource "oci_core_drg_route_distribution_statement" "route_distribution_statement" {
  for_each                  = local.distribution_statements
  drg_route_distribution_id = each.value.drg_route_distribution_id
  action                    = each.value.action
  priority                  = each.value.priority

  match_criteria {
    match_type        = each.value.match_type
    attachment_type   = each.value.attachment_type
    drg_attachment_id = each.value.drg_attachment_name != "" ? oci_core_drg_attachment.drg_vcn_attachment[each.value.drg_attachment_name].id : null
  }
}

# -----------------------------------------------------------------------------
# Create Route Tables and Rules
# -----------------------------------------------------------------------------
locals {
  route_rules = merge(
    flatten([
      for route_table_name, route_table in var.drg_route_table_map : {
        for route_rule_key, route_rule in route_table.rules : route_rule_key => {
          drg_route_table_id         = oci_core_drg_route_table.route_table[route_table_name].id
          destination                = route_rule.destination
          destination_type           = route_rule.destination_type
          next_hop_drg_attachment_id = oci_core_drg_attachment.drg_vcn_attachment[route_rule.next_hop_attachment_name].id
        }
  }])...)
}

resource "oci_core_drg_route_table" "route_table" {
  for_each                         = var.drg_route_table_map
  drg_id                           = oci_core_drg.drg.id
  display_name                     = each.value.display_name
  import_drg_route_distribution_id = each.value.route_distribution_name != null ? oci_core_drg_route_distribution.route_distribution[each.value.route_distribution_name].id : null
}

resource "oci_core_drg_route_table_route_rule" "drg_route_table_route_rule" {
  for_each                   = local.route_rules
  drg_route_table_id         = each.value.drg_route_table_id
  destination                = each.value.destination
  destination_type           = each.value.destination_type
  next_hop_drg_attachment_id = each.value.next_hop_drg_attachment_id
}
