##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

module "backup_prod_environment" {
  source = "../elz-backup/elz-backup-environment"

  count = var.enable_landing_zone_replication ? 1 : 0

  environment_prefix      = local.prod_environment.environment_prefix
  spoke_vcn_cidr          = var.backup_prod_workload_cidr
  workload_compartment_id = module.prod_environment.workload_compartment_id
  backup_region           = var.backup_region
  tenancy_ocid            = var.tenancy_ocid
  region                  = var.region

  enable_internet_gateway_hub             = var.backup_prod_enable_internet_gateway_hub
  enable_nat_gateway_hub                  = var.backup_prod_enable_nat_gateway_hub
  enable_service_gateway_hub              = var.backup_prod_enable_service_gateway_hub
  igw_hub_check                           = var.backup_igw_hub_check
  nat_gw_hub_check                        = var.backup_nat_gw_hub_check
  service_gw_hub_check                    = var.backup_service_gw_hub_check
  network_compartment_id                  = module.prod_environment.compartment.network.id
  vcn_cidr_block                          = var.backup_prod_hub_vcn_cidr_block
  public_subnet_cidr_block                = var.backup_prod_public_subnet_cidr_block
  private_subnet_cidr_block               = var.backup_prod_private_subnet_cidr_block
  private_spoke_subnet_web_cidr_block     = var.backup_prod_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block     = var.backup_prod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.backup_prod_spoke_subnet_db_cidr_block
  #add_ssh_to_security_list               = var.backup_prod_add_ssh_to_security_list

  additional_workload_subnets_cidr_blocks = var.backup_prod_additional_workload_subnets_cidr_blocks
  is_baseline_deploy                      = var.is_baseline_deploy

  enable_network_firewall                 = var.backup_enable_network_firewall_prod
  enable_traffic_threat_log               = var.backup_enable_traffic_threat_log_prod
  nfw_subnet_type                         = var.backup_nfw_subnet_type_prod
  nfw_instance_name                       = var.backup_nfw_instance_name_prod
  nfw_instance_policy                     = var.backup_nfw_instance_policy_prod
  nfw_use_existing_network                = var.backup_nfw_use_existing_network_prod

  enable_nat_gateway_spoke                = var.backup_prod_enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.backup_prod_enable_service_gateway_spoke

  create_master_encryption_key = var.backup_prod_create_master_encryption_key
  enable_replication           = var.backup_prod_vault_enable_replication
  replica_region               = var.backup_prod_vault_replica_region
  resource_label               = var.resource_label
  security_compartment_id      = module.prod_environment.compartment.security.id
  vault_type                   = var.backup_prod_vault_type
  home_compartment_id          = module.home_compartment.compartment_id

  home_compartment_name               = var.home_compartment_name
  logging_compartment_id              = module.prod_environment.compartment.logging.id
  retention_policy_duration_amount    = var.backup_prod_retention_policy_duration_amount
  retention_policy_duration_time_unit = var.backup_prod_retention_policy_duration_time_unit

  bastion_client_cidr_block_allow_list = var.backup_prod_bastion_client_cidr_block_allow_list
  environment_compartment_id           = module.prod_environment.compartment.environment.id


  is_create_alarms         = var.is_create_alarms_backup
  network_topic_endpoints  = var.prod_network_topic_endpoints_backup
  secops_topic_endpoints   = var.prod_secops_topic_endpoints_backup
  platform_topic_endpoints = var.prod_platform_topic_endpoints_backup
  identity_topic_endpoints = var.prod_identity_topic_endpoints_backup

  workload_topic_endpoints          = var.prod_workload_topic_endpoints_backup
  enable_security_monitoring_alarms = var.prod_enable_security_monitoring_alarms_backup
  enable_network_monitoring_alarms  = var.prod_enable_network_monitoring_alarms_backup
  enable_workload_monitoring_alarms = var.prod_enable_workload_monitoring_alarms_backup

  enable_vpn_or_fastconnect         = var.backup_enable_vpn_or_fastconnect
  cpe_ip_address                    = var.backup_prod_cpe_ip_address
  ipsec_connection_static_routes    = var.backup_prod_ipsec_connection_static_routes
  enable_vpn_on_environment         = var.backup_prod_enable_vpn
  cpe_display_name                  = var.backup_prod_cpe_display_name
  ipsec_display_name                = var.backup_prod_ipsec_display_name
  cpe_vendor                        = var.backup_prod_cpe_vendor
  routing                           = var.backup_prod_ipsec_routing_type
  tunnel_a_display_name             = var.backup_prod_tunnel_a_display_name
  customer_bgp_asn                  = var.backup_prod_customer_bgp_asn
  bgp_cust_tunnela_ip               = var.backup_prod_bgp_cust_tunnela_ip
  bgp_oci_tunnela_ip                = var.backup_prod_bgp_oci_tunnela_ip
  shared_secret                     = var.backup_prod_shared_secret
  tunnel_b_display_name             = var.backup_prod_tunnel_b_display_name
  fastconnect_provider              = var.backup_fastconnect_provider
  region_key                        = local.region_key[0]
  virtual_circuit_bandwidth_shape   = format("%s %s", var.backup_virtual_circuit_bandwidth_shape, "Gbps")
  virtual_circuit_display_name      = var.backup_virtual_circuit_display_name
  provider_service_key_name         = var.backup_provider_service_key_name
  fastconnect_routing_policy        = var.backup_fastconnect_routing_policy
  virtual_circuit_type              = var.backup_virtual_circuit_type
  customer_primary_bgp_peering_ip   = var.backup_customer_primary_bgp_peering_ip
  oracle_primary_bgp_peering_ip     = var.backup_oracle_primary_bgp_peering_ip
  customer_secondary_bgp_peering_ip = var.backup_customer_secondary_bgp_peering_ip
  oracle_secondary_bgp_peering_ip   = var.backup_oracle_secondary_bgp_peering_ip
  virtual_circuit_customer_asn      = var.backup_virtual_circuit_customer_asn
  virtual_circuit_is_bfd_enabled    = var.backup_virtual_circuit_is_bfd_enabled
  bgp_md5auth_key                   = var.backup_bgp_md5auth_key
  enable_fastconnect_on_environment = var.backup_prod_enable_fastconnect
  customer_onprem_ip_cidr           = var.backup_customer_onprem_ip_cidr

  depends_on = [module.prod_environment]

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}

module "backup_nonprod_environment" {
  source = "../elz-backup/elz-backup-environment"
  count = var.enable_landing_zone_replication && var.is_nonprod_env_deploy ? 1 : 0

  environment_prefix      = local.nonprod_environment.environment_prefix
  spoke_vcn_cidr          = var.backup_nonprod_workload_cidr
  workload_compartment_id = module.nonprod_environment[0].workload_compartment_id
  backup_region           = var.backup_region
  tenancy_ocid            = var.tenancy_ocid
  region                  = var.region

  enable_internet_gateway_hub             = var.backup_nonprod_enable_internet_gateway_hub
  enable_nat_gateway_hub                  = var.backup_nonprod_enable_nat_gateway_hub
  enable_service_gateway_hub              = var.backup_nonprod_enable_service_gateway_hub
  igw_hub_check                           = var.backup_igw_hub_check
  nat_gw_hub_check                        = var.backup_nat_gw_hub_check
  service_gw_hub_check                    = var.backup_service_gw_hub_check
  network_compartment_id                  = module.nonprod_environment[0].compartment.network.id
  vcn_cidr_block                          = var.backup_nonprod_hub_vcn_cidr_block
  public_subnet_cidr_block                = var.backup_nonprod_public_subnet_cidr_block
  private_subnet_cidr_block               = var.backup_nonprod_private_subnet_cidr_block
  private_spoke_subnet_web_cidr_block     = var.backup_nonprod_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block     = var.backup_nonprod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.backup_nonprod_spoke_subnet_db_cidr_block
  #add_ssh_to_security_list                = var.backup_nonprod_add_ssh_to_security_list
  additional_workload_subnets_cidr_blocks = var.backup_nonprod_additional_workload_subnets_cidr_blocks
  is_baseline_deploy                      = var.is_baseline_deploy

  enable_network_firewall                 = var.backup_enable_network_firewall_nonprod
  enable_traffic_threat_log               = var.backup_enable_traffic_threat_log_nonprod
  nfw_subnet_type                         = var.backup_nfw_subnet_type_nonprod
  nfw_instance_name                       = var.backup_nfw_instance_name_nonprod
  nfw_instance_policy                     = var.backup_nfw_instance_policy_nonprod
  nfw_use_existing_network                = var.backup_nfw_use_existing_network_nonprod

  enable_nat_gateway_spoke                = var.backup_nonprod_enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.backup_nonprod_enable_service_gateway_spoke

  create_master_encryption_key = var.backup_nonprod_create_master_encryption_key
  enable_replication           = var.backup_nonprod_vault_enable_replication
  replica_region               = var.backup_nonprod_vault_replica_region
  resource_label               = var.resource_label
  security_compartment_id      = module.nonprod_environment[0].compartment.security.id
  vault_type                   = var.backup_nonprod_vault_type
  home_compartment_id          = module.home_compartment.compartment_id

  home_compartment_name               = var.home_compartment_name
  logging_compartment_id              = module.nonprod_environment[0].compartment.logging.id
  retention_policy_duration_amount    = var.backup_nonprod_retention_policy_duration_amount
  retention_policy_duration_time_unit = var.backup_nonprod_retention_policy_duration_time_unit

  bastion_client_cidr_block_allow_list = var.backup_nonprod_bastion_client_cidr_block_allow_list
  environment_compartment_id           = module.nonprod_environment[0].compartment.environment.id

  is_create_alarms         = var.is_create_alarms_backup
  network_topic_endpoints  = var.nonprod_network_topic_endpoints_backup
  secops_topic_endpoints   = var.nonprod_secops_topic_endpoints_backup
  platform_topic_endpoints = var.nonprod_platform_topic_endpoints_backup
  identity_topic_endpoints = var.nonprod_identity_topic_endpoints_backup

  workload_topic_endpoints          = var.nonprod_workload_topic_endpoints_backup
  enable_security_monitoring_alarms = var.nonprod_enable_security_monitoring_alarms_backup
  enable_network_monitoring_alarms  = var.nonprod_enable_network_monitoring_alarms_backup
  enable_workload_monitoring_alarms = var.nonprod_enable_workload_monitoring_alarms_backup

  enable_vpn_or_fastconnect         = var.backup_enable_vpn_or_fastconnect
  cpe_ip_address                    = var.backup_nonprod_cpe_ip_address
  ipsec_connection_static_routes    = var.backup_nonprod_ipsec_connection_static_routes
  enable_vpn_on_environment         = var.backup_nonprod_enable_vpn
  cpe_display_name                  = var.backup_nonprod_cpe_display_name
  ipsec_display_name                = var.backup_nonprod_ipsec_display_name
  cpe_vendor                        = var.backup_nonprod_cpe_vendor
  routing                           = var.backup_nonprod_ipsec_routing_type
  tunnel_a_display_name             = var.backup_nonprod_tunnel_a_display_name
  customer_bgp_asn                  = var.backup_nonprod_customer_bgp_asn
  bgp_cust_tunnela_ip               = var.backup_nonprod_bgp_cust_tunnela_ip
  bgp_oci_tunnela_ip                = var.backup_nonprod_bgp_oci_tunnela_ip
  shared_secret                     = var.backup_nonprod_shared_secret
  tunnel_b_display_name             = var.backup_nonprod_tunnel_b_display_name
  fastconnect_provider              = var.backup_fastconnect_provider
  region_key                        = local.region_key[0]
  virtual_circuit_bandwidth_shape   = format("%s %s", var.backup_virtual_circuit_bandwidth_shape, "Gbps")
  virtual_circuit_display_name      = var.backup_virtual_circuit_display_name
  provider_service_key_name         = var.backup_provider_service_key_name
  fastconnect_routing_policy        = var.backup_fastconnect_routing_policy
  virtual_circuit_type              = var.backup_virtual_circuit_type
  customer_primary_bgp_peering_ip   = var.backup_customer_primary_bgp_peering_ip
  oracle_primary_bgp_peering_ip     = var.backup_oracle_primary_bgp_peering_ip
  customer_secondary_bgp_peering_ip = var.backup_customer_secondary_bgp_peering_ip
  oracle_secondary_bgp_peering_ip   = var.backup_oracle_secondary_bgp_peering_ip
  virtual_circuit_customer_asn      = var.backup_virtual_circuit_customer_asn
  virtual_circuit_is_bfd_enabled    = var.backup_virtual_circuit_is_bfd_enabled
  bgp_md5auth_key                   = var.backup_bgp_md5auth_key
  enable_fastconnect_on_environment = var.backup_nonprod_enable_fastconnect
  customer_onprem_ip_cidr           = var.backup_customer_onprem_ip_cidr

  depends_on = [module.nonprod_environment[0]]

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}