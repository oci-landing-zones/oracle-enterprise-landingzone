##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

module "network" {
  source                  = "../elz-backup-network"
  spoke_vcn_cidr          = var.spoke_vcn_cidr
  workload_compartment_id = var.workload_compartment_id
  tenancy_ocid            = var.tenancy_ocid
  backup_region           = var.backup_region
  environment_prefix      = var.environment_prefix

  enable_internet_gateway_hub             = var.enable_internet_gateway_hub
  enable_nat_gateway_hub                  = var.enable_nat_gateway_hub
  enable_service_gateway_hub              = var.enable_service_gateway_hub
  igw_hub_check                           = var.igw_hub_check
  nat_gw_hub_check                        = var.nat_gw_hub_check
  service_gw_hub_check                    = var.service_gw_hub_check
  network_compartment_id                  = var.network_compartment_id
  vcn_cidr_block                          = var.vcn_cidr_block
  public_subnet_cidr_block                = var.public_subnet_cidr_block
  private_subnet_cidr_block               = var.private_subnet_cidr_block
  private_spoke_subnet_web_cidr_block     = var.private_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block     = var.private_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.private_spoke_subnet_db_cidr_block
  #add_ssh_to_security_list               = var.add_ssh_to_security_list
  ipsec_connection_static_routes          = var.ipsec_connection_static_routes
  enable_vpn_or_fastconnect               = var.enable_vpn_or_fastconnect
  enable_vpn_on_environment               = var.enable_vpn_on_environment
  enable_fastconnect_on_environment       = var.enable_fastconnect_on_environment
  customer_onprem_ip_cidr                 = var.customer_onprem_ip_cidr
  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks
  home_compartment_id                     = var.home_compartment_id
  is_baseline_deploy                      = var.is_baseline_deploy

  enable_network_firewall                 = var.enable_network_firewall
  enable_traffic_threat_log               = var.enable_traffic_threat_log
  nfw_subnet_type                         = var.nfw_subnet_type
  nfw_instance_name                       = var.nfw_instance_name
  nfw_instance_policy                     = var.nfw_instance_policy
  nfw_use_existing_network                = var.nfw_use_existing_network
  log_group_id                            = module.logging.log_group_id

  enable_nat_gateway_spoke                = var.enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.enable_service_gateway_spoke

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}