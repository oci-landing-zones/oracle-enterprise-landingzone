# -----------------------------------------------------------------------------
# Support for multi-region deployments
# -----------------------------------------------------------------------------
locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  home_region          = [for region in local.region_subscriptions : region.region_name if region.is_home_region == true]
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.region]
}

data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}
