##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

/*
######################################################################
#                Support for multi-region deployments                #
######################################################################
locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  home_region          = [for region in local.region_subscriptions : region.region_name if region.is_home_region == true]
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.backup_region]
}
######################################################################
#                    Get Tenancy OCID From the Region                #
######################################################################
data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}
*/
######################################################################
#              Get the Private IPs using Trust Subnet                #
######################################################################
data "oci_core_private_ips" "firewall_subnet_private_ip" {
  subnet_id  = var.nfw_subnet_type == "public" ? oci_core_subnet.hub_public_subnet_backup.id : oci_core_subnet.hub_private_subnet_backup.id
  depends_on = [
    oci_network_firewall_network_firewall.network_firewall_backup
  ]
}
