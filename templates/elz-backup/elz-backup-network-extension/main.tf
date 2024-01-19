##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

module "backup_ipsec" {
  count                 = var.enable_vpn_or_fastconnect == "VPN" && var.enable_vpn_on_environment ? 1 : 0
  source                = "../../../modules/ipsec"
  compartment_ocid      = var.network_compartment_id
  cpe_ip_address        = var.cpe_ip_address
  cpe_display_name      = var.cpe_display_name
  drg_id                = var.drg_id
  ipsec_display_name    = var.ipsec_display_name
  static_routes         = var.ipsec_connection_static_routes
  cpe_vendor            = var.cpe_vendor
  routing               = var.routing
  tunnel_a_display_name = var.tunnel_a_display_name
  customer_bgp_asn      = var.customer_bgp_asn
  bgp_cust_tunnela_ip   = var.bgp_cust_tunnela_ip
  bgp_oci_tunnela_ip    = var.bgp_oci_tunnela_ip
  shared_secret         = var.shared_secret
  tunnel_b_display_name = var.tunnel_b_display_name
  providers = {
    oci = oci.backup_region
  }
}

module "backup_fastconnect" {
  count                             = var.enable_vpn_or_fastconnect == "FASTCONNECT" && var.enable_fastconnect_on_environment ? 1 : 0
  source                            = "../../../modules/fastconnect"
  compartment_ocid                  = var.network_compartment_id
  virtual_circuit_bandwidth_shape   = var.virtual_circuit_bandwidth_shape
  virtual_circuit_display_name      = var.virtual_circuit_display_name
  fastconnect_provider              = var.fastconnect_provider
  bgp_md5auth_key                   = var.bgp_md5auth_key
  provider_service_key_name         = var.provider_service_key_name
  fastconnect_routing_policy        = var.fastconnect_routing_policy
  virtual_circuit_type              = var.virtual_circuit_type
  customer_primary_bgp_peering_ip   = var.customer_primary_bgp_peering_ip
  oracle_primary_bgp_peering_ip     = var.oracle_primary_bgp_peering_ip
  customer_secondary_bgp_peering_ip = var.customer_secondary_bgp_peering_ip
  oracle_secondary_bgp_peering_ip   = var.oracle_secondary_bgp_peering_ip
  virtual_circuit_customer_asn      = var.virtual_circuit_customer_asn
  virtual_circuit_is_bfd_enabled    = var.virtual_circuit_is_bfd_enabled
  drg_id                            = var.drg_id
  region_key                        = var.region_key
  drg_route_table_vc_id             = var.drg_route_table_vc_id
  providers = {
    oci = oci.backup_region
  }
}

# -----------------------------------------------------------------------------------------
# Create RPC connection
# -----------------------------------------------------------------------------------------
locals {
  fastconnect = {
    remote_peering_connection_display_name = "RPC-${var.environment_prefix}"
  }
  drg_rpc_attachment = {
    display_name = "${var.environment_prefix}-RPC-Attachment"
  }
}

resource "oci_core_remote_peering_connection" "remote_peering_connection_backup" {
  count            = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? 1 : 0
  compartment_id   = var.network_compartment_id
  drg_id           = var.drg_id
  display_name     = local.fastconnect.remote_peering_connection_display_name
  peer_id          = var.remote_peering_connection_peer_id != null ? var.remote_peering_connection_peer_id : null
  peer_region_name = var.remote_peering_connection_peer_region_name != null ? var.remote_peering_connection_peer_region_name : null
  #providers = {
  #  oci = oci.backup_region
  #}
}

resource "oci_core_drg_attachment_management" "drg_rpc_attachment_nonprod_backup" {
  count           = var.enable_vpn_or_fastconnect == "FASTCONNECT" && !var.enable_fastconnect_on_environment ? 1 : 0
  attachment_type = "REMOTE_PEERING_CONNECTION"
  compartment_id  = var.network_compartment_id
  network_id      = oci_core_remote_peering_connection.remote_peering_connection_backup[0].id
  drg_id          = var.drg_id
  display_name    = local.drg_rpc_attachment.display_name
  # drg_route_table_id = oci_core_drg_route_table.test_drg_route_table.id
  #providers = {
  #  oci = oci.backup_region
  #}
}

resource "oci_core_drg_attachment_management" "drg_rpc_attachment_prod_backup" {
  count              = var.enable_vpn_or_fastconnect == "FASTCONNECT" && var.enable_fastconnect_on_environment ? 1 : 0
  attachment_type    = "REMOTE_PEERING_CONNECTION"
  compartment_id     = var.network_compartment_id
  network_id         = oci_core_remote_peering_connection.remote_peering_connection_backup[0].id
  drg_id             = var.drg_id
  display_name       = local.drg_rpc_attachment.display_name
  drg_route_table_id = var.drg_route_table_rpc_id
  #providers = {
  #  oci = oci.backup_region
  #}
}