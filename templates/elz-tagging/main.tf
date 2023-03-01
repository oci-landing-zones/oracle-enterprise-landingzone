locals {
  elz_tagging = {
    tag_namespace_description = "Tenancy Level Tag"
    tag_namespace_name        = "ELZ-${var.environment_prefix}-Namespace"
    is_namespace_retired      = false
    tag_map = {
      cost_center = {
        description      = "Cost Center"
        name             = "Cost_Center"
        is_cost_tracking = false
        is_retired       = false
      }
      geo_location = {
        description      = "Geo Location"
        name             = "Geo_Location"
        is_cost_tracking = false
        is_retired       = false
      }
      environment_prefix = {
        description      = "Environment"
        name             = "Environment_Prefix"
        is_cost_tracking = false
        is_retired       = false
      }
    }
    tag_default_map = {
      cost_center_tag = {
        compartment_id      = var.environment_compartment_id
        tag_definition_name = "cost_center"
        value               = var.cost_center_tagging
        is_required         = false
      }
      geo_location = {
        compartment_id      = var.environment_compartment_id
        tag_definition_name = "geo_location"
        value               = var.geo_location_tagging
        is_required         = false
      }
      environment_prefix = {
        compartment_id      = var.environment_compartment_id
        tag_definition_name = "environment_prefix"
        value               = var.environment_prefix
        is_required         = false
      }
    }
  }
}

module "elz_tagging" {
  count                     = var.enable_tagging ? 1 : 0
  source                    = "../../modules/tag"
  compartment_id            = var.tenancy_ocid
  tag_namespace_description = local.elz_tagging.tag_namespace_description
  tag_namespace_name        = local.elz_tagging.tag_namespace_name
  is_namespace_retired      = local.elz_tagging.is_namespace_retired
  tag_map                   = local.elz_tagging.tag_map
  tag_default_map           = local.elz_tagging.tag_default_map
}
