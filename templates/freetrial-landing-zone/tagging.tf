##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

locals {
  architecture_tag = {
    tag_namespace_description = "ArchitectureCenterTagNamespace"
    tag_namespace_name        = "ArchitectureCenter\\oracle-enterprise-landing-zone-freetrial-v2-${random_id.tag.hex}"
    is_namespace_retired      = false
    tag_map = {
      architecture_tag = {
        description      = "ArchitectureCenterTag"
        name             = "release"
        validator_type   = "ENUM"
        validator_values = ["release", "1.0.0", "2.0.0","3.0.0"]
        is_cost_tracking = false
        is_retired       = false
      }
    }
    tag_default_map = {
      architecture_tag = {
        compartment_id      = var.home_compartment_id
        tag_definition_name = "architecture_tag"
        value               = "3.0.0"
        is_required         = false
      }
    }
  }
}

resource "random_id" "tag" {
  byte_length = 2
}

module "architecture_tag" {
  count                     = var.is_freetrial_deploy ? 1 : 0
  source                    = "../../modules/tag"
  compartment_id            = var.tenancy_ocid
  tag_namespace_description = local.architecture_tag.tag_namespace_description
  tag_namespace_name        = local.architecture_tag.tag_namespace_name
  is_namespace_retired      = local.architecture_tag.is_namespace_retired
  tag_map                   = local.architecture_tag.tag_map
  tag_default_map           = local.architecture_tag.tag_default_map
}
