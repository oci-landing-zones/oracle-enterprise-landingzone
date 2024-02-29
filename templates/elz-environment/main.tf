##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

module "compartment" {
  source                       = "../elz-compartment"
  tenancy_ocid                 = var.tenancy_ocid
  region                       = var.region
  environment_prefix           = var.environment_prefix
  enable_compartment_delete    = var.enable_compartment_delete
  home_compartment_id          = var.home_compartment_id
  environment_compartment_name = var.environment_compartment_name
  enable_tf_state_backup       = var.enable_tf_state_backup
  enable_logging               = var.enable_logging
  is_baseline_deploy           = var.is_baseline_deploy

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

module "identity" {
  source             = "../elz-identity"
  tenancy_ocid       = var.tenancy_ocid
  region             = var.region
  environment_prefix = var.environment_prefix

  environment_compartment_id   = module.compartment.compartments.environment.id
  environment_compartment_name = module.compartment.compartments.environment.name
  shared_compartment_id        = module.compartment.compartments.shared.id
  shared_compartment_name      = module.compartment.compartments.shared.name
  security_compartment_id      = module.compartment.compartments.security.id
  security_compartment_name    = module.compartment.compartments.security.name
  network_compartment_id       = module.compartment.compartments.network.id
  network_compartment_name     = module.compartment.compartments.network.name
  domain_license_type          = var.domain_license_type
  domain_admin_email           = var.domain_admin_email
  network_admin_group_name     = var.network_admin_group_name
  security_admin_group_name    = var.security_admin_group_name
  iam_admin_group_name         = var.iam_admin_group_name
  platform_admin_group_name    = var.platform_admin_group_name
  ops_admin_group_name         = var.ops_admin_group_name
  workload_admin_group_name    = var.workload_admin_group_name
  application_admin_group_name = var.application_admin_group_name
  database_admin_group_name    = var.database_admin_group_name
  workload_compartment_id      = module.workload.compartment_id
  workload_compartment_name    = module.workload.compartment_name
  workload_compartment_names   = var.workload_compartment_names
  home_compartment_id          = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy
  resource_label               = var.resource_label

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

locals {
  budget = {
    budget_description  = "Budget targeting ${var.environment_prefix} enviroment compartment"
    budget_display_name = "OCI-ELZ-BGT-${var.environment_prefix}"
  }
}

module "budget" {
  count              = var.enable_budget ? 1 : 0
  source             = "../elz-budget"
  tenancy_ocid       = var.tenancy_ocid
  region             = var.region
  environment_prefix = var.environment_prefix

  budget_compartment_id        = var.tenancy_ocid
  budget_description           = local.budget.budget_description
  budget_display_name          = local.budget.budget_display_name
  budget_target                = module.compartment.compartments.environment.id
  budget_amount                = var.budget_amount
  budget_alert_rule_threshold  = var.budget_alert_rule_threshold
  budget_alert_rule_message    = var.budget_alert_rule_message
  budget_alert_rule_recipients = var.budget_alert_rule_recipients
  home_compartment_id          = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

module "security" {
  source                               = "../elz-security"
  enable_cloud_guard                   = var.enable_cloud_guard
  resource_label                       = var.resource_label
  home_compartment_id                  = var.home_compartment_id
  tenancy_ocid                         = var.tenancy_ocid
  environment_prefix                   = var.environment_prefix
  home_compartment_name                = var.home_compartment_name
  region                               = var.region
  environment_compartment_id           = module.compartment.compartments.environment.id
  security_compartment_id              = module.compartment.compartments.security.id
  vault_type                           = var.vault_type
  replica_region                       = var.vault_replica_region
  enable_replication                   = var.enable_vault_replication
  create_master_encryption_key         = var.create_master_encryption_key
  is_baseline_deploy                   = var.is_baseline_deploy

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

locals {
  network = {
    vcn_description  = "VCN targeting ${var.environment_prefix} enviroment compartment"
    vcn_display_name = "OCI-ELZ-VCN-${var.environment_prefix}-HUB-${local.region_key[0]}"
  }
}

module "network" {
  source                 = "../elz-network"
  tenancy_ocid           = var.tenancy_ocid
  environment_prefix     = var.environment_prefix
  region                 = var.region
  network_compartment_id = module.compartment.compartments.network.id
  home_compartment_id      = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy

  enable_internet_gateway_hub  = var.enable_internet_gateway_hub
  enable_nat_gateway_hub       = var.enable_nat_gateway_hub
  enable_service_gateway_hub   = var.enable_service_gateway_hub
  enable_nat_gateway_spoke     = var.enable_nat_gateway_spoke
  enable_service_gateway_spoke = var.enable_service_gateway_spoke

  igw_hub_check             = var.igw_hub_check
  nat_gw_hub_check          = var.nat_gw_hub_check
  service_gw_hub_check      = var.service_gw_hub_check
  nat_gw_spoke_check        = var.nat_gw_spoke_check
  service_gw_spoke_check    = var.service_gw_spoke_check
  workload_compartment_id   = module.workload.compartment_id
  workload_compartment_name = module.workload.compartment_name

  vcn_cidr_block                      = var.vcn_cidr_block
  public_subnet_cidr_block            = var.public_subnet_cidr_block
  private_subnet_cidr_block           = var.private_subnet_cidr_block
  private_spoke_subnet_web_cidr_block = var.private_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block = var.private_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block  = var.private_spoke_subnet_db_cidr_block
  hub_public_subnet_dns_label         = var.hub_public_subnet_dns_label
  hub_private_subnet_dns_label        = var.hub_private_subnet_dns_label
  spoke_vcn_cidr                      = var.spoke_vcn_cidr
  subnet_app_dns_label                = var.subnet_app_dns_label
  subnet_db_dns_label                 = var.subnet_db_dns_label
  subnet_web_dns_label                = var.subnet_web_dns_label
  ipsec_connection_static_routes      = var.ipsec_connection_static_routes
  enable_vpn_or_fastconnect           = var.enable_vpn_or_fastconnect
  enable_vpn_on_environment           = var.enable_vpn_on_environment
  enable_fastconnect_on_environment   = var.enable_fastconnect_on_environment
  customer_onprem_ip_cidr             = var.customer_onprem_ip_cidr

  log_group_id                      = module.logging.log_group_id
  enable_network_firewall           = var.enable_network_firewall
  enable_traffic_threat_log         = var.enable_traffic_threat_log
  nfw_subnet_type                   = var.nfw_subnet_type
  nfw_instance_name                 = var.nfw_instance_name
  nfw_instance_policy               = var.nfw_instance_policy
  nfw_use_existing_network          = var.nfw_use_existing_network

  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
  #depends_on = [ module.prod_environment.module.logging, module.nonprod_environment.module.logging ]
}

module "tagging" {

  source = "../elz-tagging"

  region                       = var.region
  environment_compartment_id   = module.compartment.compartments.environment.id
  environment_compartment_name = var.environment_compartment_name
  enable_tagging               = var.enable_tagging
  environment_prefix           = var.environment_prefix
  tenancy_ocid                 = var.tenancy_ocid
  cost_center_tagging          = var.cost_center_tagging
  geo_location_tagging         = var.geo_location_tagging
  home_compartment_id          = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy
  resource_label               = var.resource_label


  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

module "monitoring" {
  source = "../elz-monitoring"

  tenancy_ocid       = var.tenancy_ocid
  region             = var.region
  environment_prefix = var.environment_prefix
  resource_label     = var.resource_label
  home_compartment_id  = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy

  environment_compartment_id = module.compartment.compartments.environment.id
  security_compartment_id    = module.compartment.compartments.security.id
  network_compartment_id     = module.compartment.compartments.network.id
  workload_compartment_id    = module.workload.compartment_id

  is_create_alarms         = var.is_create_alarms
  network_topic_endpoints  = var.network_topic_endpoints
  secops_topic_endpoints   = var.secops_topic_endpoints
  platform_topic_endpoints = var.platform_topic_endpoints
  identity_topic_endpoints = var.identity_topic_endpoints
  default_log_group_id     = module.logging.log_group_id

  workload_topic_endpoints = var.workload_topic_endpoints

  enable_security_monitoring_alarms = var.enable_security_monitoring_alarms
  enable_network_monitoring_alarms  = var.enable_network_monitoring_alarms
  enable_workload_monitoring_alarms = var.enable_workload_monitoring_alarms

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
