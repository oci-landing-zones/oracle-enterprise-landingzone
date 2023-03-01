data "oci_cloud_guard_detector_recipes" "configuration_detector_recipe" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  display_name   = var.configuration_detector_recipe_display_name
}

data "oci_cloud_guard_detector_recipes" "activity_detector_recipe" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  display_name   = var.activity_detector_recipe_display_name
}

data "oci_cloud_guard_detector_recipes" "threat_detector_recipe" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  display_name   = var.threat_detector_recipe_display_name
}

data "oci_cloud_guard_responder_recipes" "responder_recipe" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  display_name   = var.responder_recipe_display_name
}