
##############################################################################
###########                     CREATE SPOKE                        ##########
##############################################################################

locals {
  vcn_spoke = {
    name      = "OCI-ELZ-VCN-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}001"
    dns_label = "backupspoke"
  }
  vcn-spoke-info = {
    spoke_security_list_display_name = "OCI-ELZ-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}-Security-List"
    route_table_display_name         = "OCI-ELZ-RTPRV-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}"
    nat_gateway_display_name         = "OCI-ELZ-NGW-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}"
    service_gateway_display_name     = "OCI-ELZ-SGW-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}"
    subnet_app_dns_label             = "appdnslabel"
    subnet_db_dns_label              = "dbdnslabel"
    subnet_web_dns_label             = "webdnslabel"
    subnet_web_display_name          = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}001"
    subnet_app_display_name          = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}002"
    subnet_db_display_name           = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}003"
  }
}

// TODO: Add drg attachment in Hub ticket
module "spoke" {
  source                     = "../elz-backup-spoke"
  vcn_display_name           = local.vcn_spoke.name
  vcn_dns_label              = local.vcn_spoke.dns_label
  workload_compartment_id    = var.workload_compartment_id
  workload_spoke_vcn_cidr    = var.spoke_vcn_cidr
  security_list_display_name = local.vcn-spoke-info.spoke_security_list_display_name

  additional_workload_subnets_cidr_blocks        = var.additional_workload_subnets_cidr_blocks
  customer_onprem_ip_cidr                        = var.customer_onprem_ip_cidr
  drg_id                                         = "" // TODO: add it in hub ticket
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
