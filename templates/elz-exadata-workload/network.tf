
module "exadata_workload_expansion_spoke" {
  source             = "../elz-exadata-spoke"
  environment_prefix = var.environment_prefix
  tenancy_ocid       = var.tenancy_ocid
  region             = var.region
  #Spoke VCN Variables
  workload_spoke_vcn_cidr = var.workload_spoke_vcn_cidr
  vcn_dns_label           = var.vcn_dns_label
  vcn_display_name        = var.vcn_display_name != "" ? var.vcn_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-VCN-${local.region_key[0]}"
  db_port                 = var.db_port
  enable_fan_events       = var.enable_fan_events
  #Spoke VCN Subnet Variables
  workload_private_spoke_subnet_lb_display_name     = var.workload_private_spoke_subnet_lb_display_name != "" ? var.workload_private_spoke_subnet_lb_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-LB"
  workload_private_spoke_subnet_app_display_name    = var.workload_private_spoke_subnet_app_display_name != "" ? var.workload_private_spoke_subnet_app_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-APP"
  workload_private_spoke_subnet_client_display_name = var.workload_private_spoke_subnet_client_display_name != "" ? var.workload_private_spoke_subnet_client_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-CLT"
  workload_private_spoke_subnet_backup_display_name = var.workload_private_spoke_subnet_backup_display_name != "" ? var.workload_private_spoke_subnet_backup_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-BKP"
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
  nat_gateway_display_name      = var.nat_gateway_display_name != "" ? var.nat_gateway_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-NAT-${local.region_key[0]}"
  service_gateway_display_name  = var.service_gateway_display_name != "" ? var.service_gateway_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SGW-${local.region_key[0]}"
  route_table_display_name      = var.route_table_display_name != "" ? var.route_table_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-RTPRV-${local.region_key[0]}"
  security_list_display_name    = var.security_list_display_name != "" ? var.security_list_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-Security-List"
  drg_id                        = var.drg_id
  nat_gw_spoke_check            = var.nat_gw_spoke_check
  service_gw_spoke_check        = var.service_gw_spoke_check
  hub_vcn_cidr_block            = var.hub_vcn_cidr_block
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
