##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.backup_region]
}

data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}