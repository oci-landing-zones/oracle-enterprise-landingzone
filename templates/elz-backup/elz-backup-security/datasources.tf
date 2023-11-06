locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.backup_region]
}

data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}