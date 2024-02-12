##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

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

data "oci_events_rules" "security_event_rules" {
  compartment_id = var.security_compartment_id

  depends_on = [ module.default_log_group, module.service_event_stream ]
}

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.tenancy_ocid
}

