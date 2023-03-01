terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      configuration_aliases = [oci, oci.home_region]
    }
  }
}


resource "oci_cloud_guard_cloud_guard_configuration" "cloud_guard_configuration" {
  provider         = oci.home_region
  compartment_id   = var.tenancy_ocid
  reporting_region = var.region
  status           = var.status
}

resource "oci_cloud_guard_target" "cloud_guard_target" {
  provider             = oci.home_region
  compartment_id       = var.compartment_id
  display_name         = var.display_name
  target_resource_id   = var.target_resource_id
  target_resource_type = var.target_resource_type
  description          = var.description

  target_detector_recipes {
    detector_recipe_id = data.oci_cloud_guard_detector_recipes.configuration_detector_recipe.detector_recipe_collection.0.items.0.id
  }

  target_detector_recipes {
    detector_recipe_id = data.oci_cloud_guard_detector_recipes.activity_detector_recipe.detector_recipe_collection.0.items.0.id
  }

  target_detector_recipes {
    detector_recipe_id = data.oci_cloud_guard_detector_recipes.threat_detector_recipe.detector_recipe_collection.0.items.0.id
  }

  target_responder_recipes {
    responder_recipe_id = data.oci_cloud_guard_responder_recipes.responder_recipe.responder_recipe_collection.0.items.0.id
  }

  depends_on = [oci_cloud_guard_cloud_guard_configuration.cloud_guard_configuration]
}