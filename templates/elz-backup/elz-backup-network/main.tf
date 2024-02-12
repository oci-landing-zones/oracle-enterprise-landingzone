##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

##############################################################################
###########            CREATE HUB AND Network Firewall              ##########
##############################################################################
locals {
  vcn_hub = {
    name      = "OCI-ELZ-VCN-${var.environment_prefix}-HUB-BACKUP"
    dns_label = "hubbcklabel"
  }
  vcn-hub-info = {
    hub_public_subnet_display_name   = "OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}001"
    hub_public_subnet_description    = "Hub Public Subnet Backup"  
    hub_public_subnet_dns_label      = "publabelbck"
    hub_private_subnet_display_name  = "OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}002"
    hub_private_subnet_description   = "Hub Private Subnet Backup"
    hub_private_subnet_dns_label     = "prilabelbck"
    hub_security_list_display_name   = "OCI-ELZ-${var.environment_prefix}-Hub-BACKUP-Security-List"
    igw_gateway_display_name         = "OCI-ELZ-IGW-${var.environment_prefix}-HUB-BACKUP"
    nat_gateway_display_name         = "OCI-ELZ-NGW-${var.environment_prefix}-HUB-BACKUP"
    srv_gateway_display_name         = "OCI-ELZ-SGW-${var.environment_prefix}-HUB-BACKUP"
  }
}

module "hub_backup" {
  source                                  = "../elz-backup-hub"
  environment_prefix                      = var.environment_prefix
  backup_region                           = var.backup_region
  enable_internet_gateway_hub             = var.enable_internet_gateway_hub
  enable_nat_gateway_hub                  = var.enable_nat_gateway_hub
  enable_service_gateway_hub              = var.enable_service_gateway_hub
  tenancy_ocid                            = var.tenancy_ocid
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
  #add_ssh_to_security_list                = var.add_ssh_to_security_list
  ipsec_connection_static_routes          = var.ipsec_connection_static_routes
  enable_vpn_or_fastconnect               = var.enable_vpn_or_fastconnect
  enable_vpn_on_environment               = var.enable_vpn_on_environment
  enable_fastconnect_on_environment       = var.enable_fastconnect_on_environment
  customer_onprem_ip_cidr                 = var.customer_onprem_ip_cidr
  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks
  home_compartment_id                     = var.home_compartment_id
  is_baseline_deploy                      = var.is_baseline_deploy
  
  hub_vcn_name                            = local.vcn_hub.name
  hub_vcn_dns_label                       = local.vcn_hub.dns_label
  hub_public_subnet_display_name          = local.vcn-hub-info.hub_public_subnet_display_name
  hub_public_subnet_description           = local.vcn-hub-info.hub_public_subnet_description
  hub_public_subnet_dns_label             = local.vcn-hub-info.hub_public_subnet_dns_label
  hub_private_subnet_display_name         = local.vcn-hub-info.hub_private_subnet_display_name
  hub_private_subnet_description          = local.vcn-hub-info.hub_private_subnet_description
  hub_private_subnet_dns_label            = local.vcn-hub-info.hub_private_subnet_dns_label
  igw_gateway_display_name                = local.vcn-hub-info.igw_gateway_display_name
  nat_gateway_display_name                = local.vcn-hub-info.nat_gateway_display_name
  srv_gateway_display_name                = local.vcn-hub-info.srv_gateway_display_name
  hub_security_list_display_name          = local.vcn-hub-info.hub_security_list_display_name

  enable_network_firewall                 = var.enable_network_firewall
  enable_traffic_threat_log               = var.enable_traffic_threat_log
  nfw_subnet_type                         = var.nfw_subnet_type
  nfw_instance_name                       = var.nfw_instance_name
  nfw_instance_policy                     = var.nfw_instance_policy
  nfw_use_existing_network                = var.nfw_use_existing_network
  log_group_id                           = var.log_group_id

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}
##############################################################################
###########                     CREATE SPOKE                        ##########
##############################################################################

locals {
  vcn_spoke = {
    name      = "OCI-ELZ-VCN-${var.environment_prefix}-SPK-BACKUP"
    dns_label = "backupspoke"
  }
  vcn-spoke-info = {
    spoke_security_list_display_name = "OCI-ELZ-${var.environment_prefix}-SPK-BACKUP-Security-List"
    route_table_display_name         = "OCI-ELZ-RTPRV-${var.environment_prefix}-SPK-BACKUP"
    nat_gateway_display_name         = "OCI-ELZ-NGW-${var.environment_prefix}-SPK-BACKUP"
    service_gateway_display_name     = "OCI-ELZ-SGW-${var.environment_prefix}-SPK-BACKUP"
    subnet_app_dns_label             = "appdnslabel"
    subnet_db_dns_label              = "dbdnslabel"
    subnet_web_dns_label             = "webdnslabel"
    subnet_web_display_name          = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}001"
    subnet_app_display_name          = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}002"
    subnet_db_display_name           = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}003"
  }
}
module "spoke" {
  source                     = "../elz-backup-spoke"
  vcn_display_name           = local.vcn_spoke.name
  vcn_dns_label              = local.vcn_spoke.dns_label
  workload_compartment_id    = var.workload_compartment_id
  workload_spoke_vcn_cidr    = var.spoke_vcn_cidr
  security_list_display_name = local.vcn-spoke-info.spoke_security_list_display_name

  additional_workload_subnets_cidr_blocks        = var.additional_workload_subnets_cidr_blocks
  customer_onprem_ip_cidr                        = var.customer_onprem_ip_cidr
  drg_id                                         = module.hub_backup.drg_id
  enable_nat_gateway_spoke                       = var.enable_nat_gateway_spoke
  enable_service_gateway_spoke                   = var.enable_service_gateway_spoke
  enable_vpn_on_environment                      = var.enable_vpn_on_environment
  enable_vpn_or_fastconnect                      = var.enable_vpn_or_fastconnect
  hub_private_subnet_cidr_block                  = var.private_subnet_cidr_block
  hub_public_subnet_cidr_block                   = var.public_subnet_cidr_block
  ipsec_connection_static_routes                 = var.ipsec_connection_static_routes
  nat_gateway_display_name                       = local.vcn-spoke-info.nat_gateway_display_name
  route_table_display_name                       = local.vcn-spoke-info.route_table_display_name
  service_gateway_display_name                   = local.vcn-spoke-info.service_gateway_display_name
  workload_private_spoke_subnet_app_cidr_block   = var.private_spoke_subnet_app_cidr_block
  workload_private_spoke_subnet_app_display_name = local.vcn-spoke-info.subnet_app_display_name
  workload_private_spoke_subnet_app_dns_label    = local.vcn-spoke-info.subnet_app_dns_label
  workload_private_spoke_subnet_db_cidr_block    = var.private_spoke_subnet_db_cidr_block
  workload_private_spoke_subnet_db_display_name  = local.vcn-spoke-info.subnet_db_display_name
  workload_private_spoke_subnet_db_dns_label     = local.vcn-spoke-info.subnet_db_dns_label
  workload_private_spoke_subnet_web_cidr_block   = var.private_spoke_subnet_web_cidr_block
  workload_private_spoke_subnet_web_display_name = local.vcn-spoke-info.subnet_web_display_name
  workload_private_spoke_subnet_web_dns_label    = local.vcn-spoke-info.subnet_web_dns_label

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}
