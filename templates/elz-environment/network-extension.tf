##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

module "network-extension" {
  source                            = "../elz-network-extension"
  tenancy_ocid                      = var.tenancy_ocid
  region                            = var.region
  environment_prefix                = var.environment_prefix

  network_compartment_id            = module.compartment.compartments.network.id
  cpe_ip_address                    = var.cpe_ip_address
  enable_vpn_or_fastconnect         = var.enable_vpn_or_fastconnect
  ipsec_connection_static_routes    = var.ipsec_connection_static_routes
  enable_vpn_on_environment         = var.enable_vpn_on_environment
  cpe_display_name                  = var.cpe_display_name
  ipsec_display_name                = var.ipsec_display_name
  drg_id                            = module.network.drg_id
  cpe_vendor                        = var.cpe_vendor
  routing                           = var.routing
  tunnel_a_display_name             = var.tunnel_a_display_name
  customer_bgp_asn                  = var.customer_bgp_asn
  bgp_cust_tunnela_ip               = var.bgp_cust_tunnela_ip
  bgp_oci_tunnela_ip                = var.bgp_oci_tunnela_ip
  shared_secret                     = var.shared_secret
  tunnel_b_display_name             = var.tunnel_b_display_name
  fastconnect_provider              = var.fastconnect_provider
  region_key                        = var.region_key
  virtual_circuit_bandwidth_shape   = var.virtual_circuit_bandwidth_shape
  virtual_circuit_display_name      = var.virtual_circuit_display_name
  provider_service_key_name         = var.provider_service_key_name
  fastconnect_routing_policy        = var.fastconnect_routing_policy
  virtual_circuit_type              = var.virtual_circuit_type
  customer_primary_bgp_peering_ip   = var.customer_primary_bgp_peering_ip
  oracle_primary_bgp_peering_ip     = var.oracle_primary_bgp_peering_ip
  customer_secondary_bgp_peering_ip = var.customer_secondary_bgp_peering_ip
  oracle_secondary_bgp_peering_ip   = var.oracle_secondary_bgp_peering_ip
  virtual_circuit_customer_asn      = var.virtual_circuit_customer_asn
  virtual_circuit_is_bfd_enabled    = var.virtual_circuit_is_bfd_enabled
  bgp_md5auth_key                   = var.bgp_md5auth_key
  enable_fastconnect_on_environment = var.enable_fastconnect_on_environment
  remote_peering_connection_peer_id = var.remote_peering_connection_peer_id
  remote_peering_connection_peer_region_name = var.remote_peering_connection_peer_region_name
  drg_route_table_rpc_id            = var.enable_vpn_or_fastconnect == "FASTCONNECT" && var.enable_fastconnect_on_environment ? module.network.drg_route_tables.RT-RPC.id : null
  drg_route_table_vc_id             = var.enable_vpn_or_fastconnect == "FASTCONNECT" && var.enable_fastconnect_on_environment ? module.network.drg_route_tables.RT-Onprem.id : null
  home_compartment_id               = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
