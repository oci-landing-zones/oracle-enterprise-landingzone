
module "network" {
  source                  = "../elz-backup-network"
  spoke_vcn_cidr          = var.spoke_vcn_cidr
  workload_compartment_id = var.workload_compartment_id
  tenancy_ocid            = var.tenancy_ocid
  backup_region           = var.backup_region
  environment_prefix      = var.environment_prefix

  providers = {
    oci = oci
    oci.backup_region = oci.backup_region
  }

  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks
  customer_onprem_ip_cidr                 = var.customer_onprem_ip_cidr
  enable_nat_gateway_spoke                = var.enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.enable_service_gateway_spoke
  enable_vpn_on_environment               = var.enable_vpn_on_environment
  enable_vpn_or_fastconnect               = var.enable_vpn_or_fastconnect
  ipsec_connection_static_routes          = var.ipsec_connection_static_routes
  private_spoke_subnet_app_cidr_block     = var.private_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.private_spoke_subnet_db_cidr_block
  private_spoke_subnet_web_cidr_block     = var.private_spoke_subnet_web_cidr_block
  private_subnet_cidr_block               = var.private_subnet_cidr_block
  public_subnet_cidr_block                = var.public_subnet_cidr_block
}