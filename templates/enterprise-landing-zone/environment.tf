##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# -----------------------------------------------------------------------------
# Prod Enviroment Resources
# -----------------------------------------------------------------------------
locals {
  prod_environment = {
    environment_prefix     = "P"
    enable_tf_state_backup = false
    enable_logging         = true
  }
}

module "prod_environment" {
  source = "../elz-environment"

  tenancy_ocid   = var.tenancy_ocid
  region         = var.region
  resource_label = var.resource_label

  home_compartment_id        = module.home_compartment.compartment_id
  environment_prefix         = local.prod_environment.environment_prefix
  enable_tf_state_backup     = local.prod_environment.enable_tf_state_backup
  enable_logging             = local.prod_environment.enable_logging
  domain_admin_email         = var.prod_domain_admin_email
  network_admin_group_name   = var.prod_network_admin_group_name
  iam_admin_group_name       = var.prod_iam_admin_group_name
  platform_admin_group_name  = var.prod_platform_admin_group_name
  ops_admin_group_name       = var.prod_ops_admin_group_name
  security_admin_group_name  = var.prod_security_admin_group_name
  workload_compartment_names = var.prod_workload_compartment_names
  is_baseline_deploy         = var.is_baseline_deploy
  enable_compartment_delete  = var.enable_compartment_delete

  workload_admin_group_name    = var.prod_workload_admin_group_name
  application_admin_group_name = var.prod_application_admin_group_name
  database_admin_group_name    = var.prod_database_admin_group_name

  enable_budget                = var.prod_enable_budget
  budget_amount                = var.prod_budget_amount
  budget_alert_rule_threshold  = var.prod_budget_alert_rule_threshold
  budget_alert_rule_message    = var.prod_budget_alert_rule_message
  budget_alert_rule_recipients = var.prod_budget_alert_rule_recipients
  enable_cloud_guard           = var.enable_cloud_guard
  is_create_alarms             = var.is_create_alarms
  is_service_connector_limit   = var.is_service_connector_limit
  domain_license_type          = var.domain_license_type

  home_compartment_name             = var.home_compartment_name
  enable_vpn_or_fastconnect         = var.enable_vpn_or_fastconnect
  cpe_ip_address                    = var.prod_cpe_ip_address
  ipsec_connection_static_routes    = var.prod_ipsec_connection_static_routes
  enable_vpn_on_environment         = var.prod_enable_vpn
  cpe_display_name                  = var.prod_cpe_display_name
  ipsec_display_name                = var.prod_ipsec_display_name
  cpe_vendor                        = var.prod_cpe_vendor
  routing                           = var.prod_ipsec_routing_type
  tunnel_a_display_name             = var.prod_tunnel_a_display_name
  customer_bgp_asn                  = var.prod_customer_bgp_asn
  bgp_cust_tunnela_ip               = var.prod_bgp_cust_tunnela_ip
  bgp_oci_tunnela_ip                = var.prod_bgp_oci_tunnela_ip
  shared_secret                     = var.prod_shared_secret
  tunnel_b_display_name             = var.prod_tunnel_b_display_name
  fastconnect_provider              = var.fastconnect_provider
  region_key                        = local.region_key[0]
  virtual_circuit_bandwidth_shape   = format("%s %s", var.virtual_circuit_bandwidth_shape, "Gbps")
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
  enable_fastconnect_on_environment = var.prod_enable_fastconnect
  customer_onprem_ip_cidr           = var.customer_onprem_ip_cidr

  enable_internet_gateway_hub  = var.prod_enable_internet_gateway_hub
  enable_nat_gateway_hub       = var.prod_enable_nat_gateway_hub
  enable_service_gateway_hub   = var.prod_enable_service_gateway_hub
  enable_nat_gateway_spoke     = var.prod_enable_nat_gateway_spoke
  enable_service_gateway_spoke = var.prod_enable_service_gateway_spoke

  igw_hub_check          = var.igw_hub_check
  nat_gw_hub_check       = var.nat_gw_hub_check
  service_gw_hub_check   = var.service_gw_hub_check
  nat_gw_spoke_check     = var.nat_gw_spoke_check
  service_gw_spoke_check = var.service_gw_spoke_check

  vcn_cidr_block            = var.prod_hub_vcn_cidr_block
  public_subnet_cidr_block  = var.prod_hub_public_subnet_cidr_block
  private_subnet_cidr_block = var.prod_hub_private_subnet_cidr_block

  spoke_vcn_cidr                      = var.prod_spoke_vcn_cidr
  private_spoke_subnet_web_cidr_block = var.prod_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block = var.prod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block  = var.prod_spoke_subnet_db_cidr_block
  hub_public_subnet_dns_label         = var.prod_hub_public_subnet_dns_label
  hub_private_subnet_dns_label        = var.prod_hub_private_subnet_dns_label
  subnet_app_dns_label                = var.prod_subnet_app_dns_label
  subnet_db_dns_label                 = var.prod_subnet_db_dns_label
  subnet_web_dns_label                = var.prod_subnet_web_dns_label

  enable_network_firewall   = var.enable_network_firewall_prod
  enable_traffic_threat_log = var.enable_traffic_threat_log_prod
  nfw_subnet_type           = var.nfw_subnet_type_prod
  nfw_instance_name         = var.nfw_instance_name_prod
  nfw_instance_policy       = var.nfw_instance_policy_prod
  nfw_use_existing_network  = var.nfw_use_existing_network_prod

  enable_bastion                       = var.prod_enable_bastion
  bastion_client_cidr_block_allow_list = var.prod_bastion_client_cidr_block_allow_list
  vault_type                           = var.prod_vault_type
  vault_replica_region                 = var.prod_vault_replica_region
  enable_vault_replication             = var.prod_enable_vault_replication
  create_master_encryption_key         = var.prod_create_master_encryption_key

  retention_policy_duration_amount    = var.prod_retention_policy_duration_amount
  retention_policy_duration_time_unit = var.prod_retention_policy_duration_time_unit

  enable_tagging       = var.prod_enable_tagging
  cost_center_tagging  = var.prod_cost_center_tagging
  geo_location_tagging = var.prod_geo_location_tagging

  network_topic_endpoints  = var.prod_network_topic_endpoints
  secops_topic_endpoints   = var.prod_secops_topic_endpoints
  platform_topic_endpoints = var.prod_platform_topic_endpoints
  identity_topic_endpoints = var.prod_identity_topic_endpoints

  workload_topic_endpoints          = var.prod_workload_topic_endpoints
  enable_security_monitoring_alarms = var.prod_enable_security_monitoring_alarms
  enable_network_monitoring_alarms  = var.prod_enable_network_monitoring_alarms
  enable_workload_monitoring_alarms = var.prod_enable_workload_monitoring_alarms
  enable_datasafe                   = var.enable_datasafe

  workload_name_prefix                    = var.workload_name_prefix
  additional_workload_subnets_cidr_blocks = var.prod_additional_workload_subnets_cidr_blocks

  # Access Governance Variables

  ag_current_user_ocid          = var.current_user_ocid
  ag_api_fingerprint            = var.api_fingerprint
  ag_region                     = var.region
  ag_tenancy_ocid               = var.tenancy_ocid
  ag_api_private_key_path       = var.api_private_key_path
  admin_domain_name             = var.admin_domain_name
  admin_domain_compartment_ocid = var.admin_domain_compartment_ocid

  enable_access_governance          = var.prod_enable_access_governance
  service_instance_description      = var.prod_service_instance_description
  service_instance_display_name     = var.prod_service_instance_display_name
  ag_license_type                   = var.prod_ag_license_type
  agcs_user_domain_name             = var.prod_agcs_user_domain_name
  agcs_user_email                   = var.prod_agcs_user_email
  agcs_user_fingerprint_oci_system  = var.prod_agcs_user_fingerprint_oci_system
  agcs_user_group_display_name      = var.prod_agcs_user_group_display_name
  agcs_user_name                    = var.prod_agcs_user_name
  agcs_user_ocid_oci_system         = var.prod_agcs_user_ocid_oci_system
  agcs_user_private_key             = var.prod_agcs_user_private_key
  agcs_user_private_key_path        = var.prod_agcs_user_private_key_path
  agcs_user_region_oci_system       = var.prod_agcs_user_region_oci_system
  agcs_user_tenancy_ocid_oci_system = var.prod_agcs_user_tenancy_ocid_oci_system
  oci_system_description            = var.prod_oci_system_description
  oci_system_name                   = var.prod_oci_system_name
  use_existing_agcs_user            = var.prod_use_existing_agcs_user

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

  depends_on = [
    module.cloud_guard_root_policy,
    module.cloud_guard_target_policy,
    module.vss_policy,
    module.home_compartment
  ]
}

# -----------------------------------------------------------------------------
# Non-Prod Enviroment Resources
# -----------------------------------------------------------------------------
locals {
  nonprod_environment = {
    environment_prefix     = "N"
    enable_tf_state_backup = false
    enable_logging         = true
  }
}

module "nonprod_environment" {
  count  =  var.is_nonprod_env_deploy   ? 1 : 0
  source =  "../elz-environment"

  tenancy_ocid   = var.tenancy_ocid
  region         = var.region
  resource_label = var.resource_label

  home_compartment_id        = module.home_compartment.compartment_id
  environment_prefix         = local.nonprod_environment.environment_prefix
  enable_tf_state_backup     = local.nonprod_environment.enable_tf_state_backup
  enable_logging             = local.nonprod_environment.enable_logging
  domain_admin_email         = var.nonprod_domain_admin_email
  network_admin_group_name   = var.nonprod_network_admin_group_name
  iam_admin_group_name       = var.nonprod_iam_admin_group_name
  platform_admin_group_name  = var.nonprod_platform_admin_group_name
  ops_admin_group_name       = var.nonprod_ops_admin_group_name
  security_admin_group_name  = var.nonprod_security_admin_group_name
  workload_compartment_names = var.nonprod_workload_compartment_names
  is_baseline_deploy         = var.is_baseline_deploy
  enable_compartment_delete  = var.enable_compartment_delete

  workload_admin_group_name    = var.nonprod_workload_admin_group_name
  application_admin_group_name = var.nonprod_application_admin_group_name
  database_admin_group_name    = var.nonprod_database_admin_group_name

  enable_budget                     = var.nonprod_enable_budget
  budget_amount                     = var.nonprod_budget_amount
  budget_alert_rule_threshold       = var.nonprod_budget_alert_rule_threshold
  budget_alert_rule_message         = var.nonprod_budget_alert_rule_message
  budget_alert_rule_recipients      = var.nonprod_budget_alert_rule_recipients
  is_create_alarms                  = var.is_create_alarms
  is_service_connector_limit        = var.is_service_connector_limit
  domain_license_type               = var.domain_license_type
  enable_cloud_guard                = var.enable_cloud_guard
  home_compartment_name             = var.home_compartment_name
  enable_vpn_or_fastconnect         = var.enable_vpn_or_fastconnect
  cpe_ip_address                    = var.nonprod_cpe_ip_address
  ipsec_connection_static_routes    = var.nonprod_ipsec_connection_static_routes
  enable_vpn_on_environment         = var.nonprod_enable_vpn
  cpe_display_name                  = var.nonprod_cpe_display_name
  ipsec_display_name                = var.nonprod_ipsec_display_name
  cpe_vendor                        = var.nonprod_cpe_vendor
  routing                           = var.nonprod_ipsec_routing_type
  tunnel_a_display_name             = var.nonprod_tunnel_a_display_name
  customer_bgp_asn                  = var.nonprod_customer_bgp_asn
  bgp_cust_tunnela_ip               = var.nonprod_bgp_cust_tunnela_ip
  bgp_oci_tunnela_ip                = var.nonprod_bgp_oci_tunnela_ip
  shared_secret                     = var.nonprod_shared_secret
  tunnel_b_display_name             = var.nonprod_tunnel_b_display_name
  fastconnect_provider              = var.fastconnect_provider
  region_key                        = local.region_key[0]
  virtual_circuit_bandwidth_shape   = format("%s %s", var.virtual_circuit_bandwidth_shape, "Gbps")
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
  enable_fastconnect_on_environment = var.nonprod_enable_fastconnect
  customer_onprem_ip_cidr           = var.customer_onprem_ip_cidr

  enable_internet_gateway_hub  = var.nonprod_enable_internet_gateway_hub
  enable_nat_gateway_hub       = var.nonprod_enable_nat_gateway_hub
  enable_service_gateway_hub   = var.nonprod_enable_service_gateway_hub
  enable_nat_gateway_spoke     = var.nonprod_enable_nat_gateway_spoke
  enable_service_gateway_spoke = var.nonprod_enable_service_gateway_spoke

  igw_hub_check          = var.igw_hub_check
  nat_gw_hub_check       = var.nat_gw_hub_check
  service_gw_hub_check   = var.service_gw_hub_check
  nat_gw_spoke_check     = var.nat_gw_spoke_check
  service_gw_spoke_check = var.service_gw_spoke_check

  vcn_cidr_block            = var.nonprod_hub_vcn_cidr_block
  public_subnet_cidr_block  = var.nonprod_hub_public_subnet_cidr_block
  private_subnet_cidr_block = var.nonprod_hub_private_subnet_cidr_block

  spoke_vcn_cidr                      = var.nonprod_spoke_vcn_cidr
  private_spoke_subnet_web_cidr_block = var.nonprod_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block = var.nonprod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block  = var.nonprod_spoke_subnet_db_cidr_block
  hub_public_subnet_dns_label         = var.nonprod_hub_public_subnet_dns_label
  hub_private_subnet_dns_label        = var.nonprod_hub_private_subnet_dns_label
  subnet_app_dns_label                = var.nonprod_subnet_app_dns_label
  subnet_db_dns_label                 = var.nonprod_subnet_db_dns_label
  subnet_web_dns_label                = var.nonprod_subnet_web_dns_label

  enable_network_firewall   = var.enable_network_firewall_nonprod
  enable_traffic_threat_log = var.enable_traffic_threat_log_nonprod
  nfw_subnet_type           = var.nfw_subnet_type_nonprod
  nfw_instance_name         = var.nfw_instance_name_nonprod
  nfw_instance_policy       = var.nfw_instance_policy_nonprod
  nfw_use_existing_network  = var.nfw_use_existing_network_nonprod

  enable_bastion                       = var.nonprod_enable_bastion
  bastion_client_cidr_block_allow_list = var.nonprod_bastion_client_cidr_block_allow_list
  vault_type                           = var.nonprod_vault_type
  vault_replica_region                 = var.nonprod_vault_replica_region
  enable_vault_replication             = var.nonprod_enable_vault_replication
  create_master_encryption_key         = var.nonprod_create_master_encryption_key

  retention_policy_duration_amount    = var.nonprod_retention_policy_duration_amount
  retention_policy_duration_time_unit = var.nonprod_retention_policy_duration_time_unit

  enable_tagging       = var.nonprod_enable_tagging
  cost_center_tagging  = var.nonprod_cost_center_tagging
  geo_location_tagging = var.nonprod_geo_location_tagging


  network_topic_endpoints  = var.nonprod_network_topic_endpoints
  secops_topic_endpoints   = var.nonprod_secops_topic_endpoints
  platform_topic_endpoints = var.nonprod_platform_topic_endpoints
  identity_topic_endpoints = var.nonprod_identity_topic_endpoints

  workload_topic_endpoints          = var.nonprod_workload_topic_endpoints
  enable_security_monitoring_alarms = var.nonprod_enable_security_monitoring_alarms
  enable_network_monitoring_alarms  = var.nonprod_enable_network_monitoring_alarms
  enable_workload_monitoring_alarms = var.nonprod_enable_workload_monitoring_alarms
  enable_datasafe                   = var.enable_datasafe

  #workload_compartment_id             = module.nonprod_environment[0].workload_compartment_id

  remote_peering_connection_peer_id          = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? module.prod_environment.rpc_id : null
  remote_peering_connection_peer_region_name = var.region

  workload_name_prefix                    = var.workload_name_prefix
  additional_workload_subnets_cidr_blocks = var.nonprod_additional_workload_subnets_cidr_blocks

  # Access Governance Variables
  ag_current_user_ocid          = var.current_user_ocid
  ag_api_fingerprint            = var.api_fingerprint
  ag_region                     = var.region
  ag_tenancy_ocid               = var.tenancy_ocid
  ag_api_private_key_path       = var.api_private_key_path
  admin_domain_name             = var.admin_domain_name
  admin_domain_compartment_ocid = var.admin_domain_compartment_ocid

  enable_access_governance          = var.nonprod_enable_access_governance
  service_instance_description      = var.nonprod_service_instance_description
  service_instance_display_name     = var.nonprod_service_instance_display_name
  ag_license_type                   = var.nonprod_ag_license_type
  agcs_user_domain_name             = var.nonprod_agcs_user_domain_name
  agcs_user_email                   = var.nonprod_agcs_user_email
  agcs_user_fingerprint_oci_system  = var.nonprod_agcs_user_fingerprint_oci_system
  agcs_user_group_display_name      = var.nonprod_agcs_user_group_display_name
  agcs_user_name                    = var.nonprod_agcs_user_name
  agcs_user_ocid_oci_system         = var.nonprod_agcs_user_ocid_oci_system
  agcs_user_private_key             = var.nonprod_agcs_user_private_key
  agcs_user_private_key_path        = var.nonprod_agcs_user_private_key_path
  agcs_user_region_oci_system       = var.nonprod_agcs_user_region_oci_system
  agcs_user_tenancy_ocid_oci_system = var.nonprod_agcs_user_tenancy_ocid_oci_system
  oci_system_description            = var.nonprod_oci_system_description
  oci_system_name                   = var.nonprod_oci_system_name
  use_existing_agcs_user            = var.nonprod_use_existing_agcs_user

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

  depends_on = [
    module.cloud_guard_root_policy,
    module.cloud_guard_target_policy,
    module.vss_policy,
    module.home_compartment
  ]
}
