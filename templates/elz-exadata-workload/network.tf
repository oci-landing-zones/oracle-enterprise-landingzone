################################################################
#        Workload Expansion Spoke NW Configuration             #
################################################################
module "exadata_workload_expansion_spoke" {
  source             = "../elz-exadata-spoke"
  environment_prefix = var.environment_prefix
  tenancy_ocid       = var.tenancy_ocid
  region             = var.region
  #Spoke VCN Variables
  workload_spoke_vcn_cidr = var.workload_spoke_vcn_cidr
  vcn_dns_label           = var.vcn_dns_label
  vcn_display_name        = var.vcn_display_name != "" ? var.vcn_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-VCN-${local.region_key[0]}"
  db_port                 = var.db_port
  fan_events_enabled      = var.fan_events_enabled
  #Spoke VCN Subnet Variables
  workload_private_spoke_subnet_lb_display_name     = var.workload_private_spoke_subnet_lb_display_name != "" ? var.workload_private_spoke_subnet_lb_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-VCN-SUB-${local.region_key[0]}-001"
  workload_private_spoke_subnet_app_display_name    = var.workload_private_spoke_subnet_app_display_name != "" ? var.workload_private_spoke_subnet_app_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-VCN-SUB-${local.region_key[0]}-002"
  workload_private_spoke_subnet_client_display_name = var.workload_private_spoke_subnet_client_display_name != "" ? var.workload_private_spoke_subnet_client_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-VCN-SUB-${local.region_key[0]}-003"
  workload_private_spoke_subnet_backup_display_name = var.workload_private_spoke_subnet_backup_display_name != "" ? var.workload_private_spoke_subnet_backup_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-VCN-SUB-${local.region_key[0]}-004"
  workload_private_spoke_subnet_lb_cidr_block       = var.workload_private_spoke_subnet_lb_cidr_block
  workload_private_spoke_subnet_app_cidr_block      = var.workload_private_spoke_subnet_app_cidr_block
  workload_private_spoke_subnet_client_cidr_block   = var.workload_private_spoke_subnet_client_cidr_block
  workload_private_spoke_subnet_backup_cidr_block   = var.workload_private_spoke_subnet_backup_cidr_block
  workload_private_spoke_subnet_lb_dns_label        = var.workload_private_spoke_subnet_lb_dns_label
  workload_private_spoke_subnet_app_dns_label       = var.workload_private_spoke_subnet_app_dns_label
  workload_private_spoke_subnet_client_dns_label    = var.workload_private_spoke_subnet_client_dns_label
  workload_private_spoke_subnet_backup_dns_label    = var.workload_private_spoke_subnet_backup_dns_label

  #VCN Gateway Variables
  enable_nat_gateway_spoke      = var.enable_nat_gateway_spoke
  nat_gateway_display_name      = var.nat_gateway_display_name != "" ? var.nat_gateway_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-NAT-${local.region_key[0]}"
  service_gateway_display_name  = var.service_gateway_display_name != "" ? var.service_gateway_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-SGW-${local.region_key[0]}"
  route_table_display_name      = var.route_table_display_name != "" ? var.route_table_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-RTPRV-${local.region_key[0]}"
  security_list_display_name    = var.security_list_display_name != "" ? var.security_list_display_name : "OCI-ELZ-${var.workload_prefix}-EXAEXP-SPK-Security-List"
  drg_id                        = var.drg_id
  nat_gw_spoke_check            = var.nat_gw_spoke_check
  service_gw_spoke_check        = var.service_gw_spoke_check
  hub_public_subnet_cidr_block  = var.hub_public_subnet_cidr_block
  hub_private_subnet_cidr_block = var.hub_private_subnet_cidr_block
  workload_compartment_id       = module.workload_compartment.compartment_id
  workload_compartment_name     = module.workload_compartment.compartment_name

  customer_onprem_ip_cidr        = var.customer_onprem_ip_cidr
  enable_vpn_on_environment      = var.enable_vpn_on_environment
  enable_vpn_or_fastconnect      = var.enable_vpn_or_fastconnect
  ipsec_connection_static_routes = var.ipsec_connection_static_routes

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
