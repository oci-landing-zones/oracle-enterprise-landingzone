##############################################################################
###########                       CREATE HUB                        ##########
##############################################################################

module "hub" {
  source                                  = "../elz-hub"
  tenancy_ocid                            = var.tenancy_ocid
  region                                  = var.region
  environment_prefix                      = var.environment_prefix
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
  add_ssh_to_security_list                = var.add_ssh_to_security_list
  ipsec_connection_static_routes          = var.ipsec_connection_static_routes
  enable_vpn_or_fastconnect               = var.enable_vpn_or_fastconnect
  enable_vpn_on_environment               = var.enable_vpn_on_environment
  enable_fastconnect_on_environment       = var.enable_fastconnect_on_environment
  customer_onprem_ip_cidr                 = var.customer_onprem_ip_cidr
  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

locals {
  vcn_spoke = {
    name      = "OCI-ELZ-VCN-${var.environment_prefix}-SPK-${local.region_key[0]}001"
    dns_label = "spokelabel"
  }
  list_info = {
    spoke_security_list_display_name = "OCI-ELZ-${var.environment_prefix}-Spk-Security-List"
    route_table_display_name         = "OCI-ELZ-RTPRV-${var.environment_prefix}-SPK001"
    nat_gateway_display_name         = "OCI-ELZ-NGW-${var.environment_prefix}-SPK"
    service_gateway_display_name     = "OCI-ELZ-SGW-${var.environment_prefix}-SPK"
    subnet_app_dns_label             = "appdnslabel"
    subnet_db_dns_label              = "dbdnslabel"
    subnet_web_dns_label             = "webdnslabel"
    subnet_web_display_name          = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}001"
    subnet_app_display_name          = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}002"
    subnet_db_display_name           = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}003"

  }
}

module "spoke" {
  source                                         = "../elz-spoke"
  drg_id                                         = module.hub.drg_id
  enable_nat_gateway_spoke                       = var.enable_nat_gateway_spoke
  enable_service_gateway_spoke                   = var.enable_service_gateway_spoke
  environment_prefix                             = var.environment_prefix
  hub_private_subnet_cidr_block                  = var.private_subnet_cidr_block
  hub_public_subnet_cidr_block                   = var.public_subnet_cidr_block
  nat_gateway_display_name                       = local.list_info.nat_gateway_display_name
  region                                         = var.region
  route_table_display_name                       = local.list_info.route_table_display_name
  security_list_display_name                     = local.list_info.spoke_security_list_display_name
  service_gateway_display_name                   = local.list_info.service_gateway_display_name
  tenancy_ocid                                   = var.tenancy_ocid
  vcn_display_name                               = local.vcn_spoke.name
  vcn_dns_label                                  = local.vcn_spoke.dns_label
  workload_compartment_id                        = var.workload_compartment_id
  workload_private_spoke_subnet_app_cidr_block   = var.private_spoke_subnet_app_cidr_block
  workload_private_spoke_subnet_app_display_name = local.list_info.subnet_app_display_name
  workload_private_spoke_subnet_app_dns_label    = local.list_info.subnet_app_dns_label
  workload_private_spoke_subnet_db_cidr_block    = var.private_spoke_subnet_db_cidr_block
  workload_private_spoke_subnet_db_display_name  = local.list_info.subnet_db_display_name
  workload_private_spoke_subnet_db_dns_label     = local.list_info.subnet_db_dns_label
  workload_private_spoke_subnet_web_cidr_block   = var.private_spoke_subnet_web_cidr_block
  workload_private_spoke_subnet_web_display_name = local.list_info.subnet_web_display_name
  workload_private_spoke_subnet_web_dns_label    = local.list_info.subnet_web_dns_label
  workload_spoke_vcn_cidr                        = var.spoke_vcn_cidr
  enable_vpn_or_fastconnect                      = var.enable_vpn_or_fastconnect
  enable_vpn_on_environment                      = var.enable_vpn_on_environment
  customer_onprem_ip_cidr                        = var.customer_onprem_ip_cidr
  ipsec_connection_static_routes                 = var.ipsec_connection_static_routes

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

