terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_identity_tag_namespace" "tag_namespace" {
  compartment_id = var.compartment_id
  description    = var.tag_namespace_description
  name           = var.tag_namespace_name
  is_retired     = var.is_namespace_retired
}

resource "oci_identity_tag" "tag" {
  for_each         = var.tag_map
  name             = each.value.name
  description      = each.value.description
  tag_namespace_id = oci_identity_tag_namespace.tag_namespace.id
  is_cost_tracking = each.value.is_cost_tracking
  is_retired       = each.value.is_retired

  dynamic "validator" {
    # validator block is optional for this resource but can not be left empty
    for_each = lookup(each.value, "validator_type", null) != null ? ["optional_block"] : []
    content {
      validator_type = each.value.validator_type
      values         = each.value.validator_values
    }
  }
}

resource "time_sleep" "tag_creation_delay" {
  depends_on      = [oci_identity_tag.tag]
  create_duration = "90s"
}

resource "oci_identity_tag_default" "tag_default" {
  for_each          = var.tag_default_map
  compartment_id    = each.value.compartment_id
  tag_definition_id = oci_identity_tag.tag[each.value.tag_definition_name].id
  value             = each.value.value
  is_required       = each.value.is_required

  depends_on = [
    time_sleep.tag_creation_delay
  ]
}
