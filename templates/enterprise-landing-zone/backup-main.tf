
module "backup_prod_environment" {
  source = "../elz-backup/elz-backup-environment"

  count = var.enable_landing_zone_replication ? 1 : 0

  environment_prefix      = local.prod_environment.environment_prefix
  spoke_vcn_cidr          = var.backup_prod_workload_cidr
  workload_compartment_id = module.prod_environment.workload_compartment_id
  backup_region           = var.backup_region
  tenancy_ocid            = var.tenancy_ocid

  additional_workload_subnets_cidr_blocks = var.backup_prod_additional_workload_subnets_cidr_blocks
  customer_onprem_ip_cidr                 = var.customer_onprem_ip_cidr
  enable_nat_gateway_spoke                = var.backup_prod_enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.backup_prod_enable_service_gateway_spoke
  enable_vpn_on_environment               = var.backup_prod_enable_vpn
  enable_vpn_or_fastconnect               = var.backup_enable_vpn_or_fastconnect
  ipsec_connection_static_routes          = var.backup_prod_ipsec_connection_static_routes
  private_spoke_subnet_app_cidr_block     = var.backup_prod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.backup_prod_spoke_subnet_db_cidr_block
  private_spoke_subnet_web_cidr_block     = var.backup_prod_spoke_subnet_web_cidr_block
  private_subnet_cidr_block               = var.backup_prod_hub_private_subnet_cidr_block
  public_subnet_cidr_block                = var.backup_prod_hub_public_subnet_cidr_block

  create_master_encryption_key = var.backup_prod_create_master_encryption_key
  enable_replication           = var.backup_prod_vault_enable_replication
  replica_region               = var.backup_prod_vault_replica_region
  resource_label               = var.resource_label
  security_compartment_id      = module.prod_environment.compartment.security.id
  vault_type                   = var.backup_prod_vault_type
  home_compartment_id          = module.home_compartment.compartment_id

  depends_on = [module.prod_environment]

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }

}

module "backup_nonprod_environment" {
  source = "../elz-backup/elz-backup-environment"

  count = var.enable_landing_zone_replication ? 1 : 0

  environment_prefix      = local.nonprod_environment.environment_prefix
  spoke_vcn_cidr          = var.backup_nonprod_workload_cidr
  workload_compartment_id = module.nonprod_environment.workload_compartment_id
  backup_region           = var.backup_region
  tenancy_ocid            = var.tenancy_ocid


  additional_workload_subnets_cidr_blocks = var.backup_nonprod_additional_workload_subnets_cidr_blocks
  customer_onprem_ip_cidr                 = var.customer_onprem_ip_cidr
  enable_nat_gateway_spoke                = var.backup_nonprod_enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.backup_nonprod_enable_service_gateway_spoke
  enable_vpn_on_environment               = var.backup_nonprod_enable_vpn
  enable_vpn_or_fastconnect               = var.backup_enable_vpn_or_fastconnect
  ipsec_connection_static_routes          = var.backup_nonprod_ipsec_connection_static_routes
  private_spoke_subnet_app_cidr_block     = var.backup_nonprod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.backup_nonprod_spoke_subnet_db_cidr_block
  private_spoke_subnet_web_cidr_block     = var.backup_nonprod_spoke_subnet_web_cidr_block
  private_subnet_cidr_block               = var.backup_nonprod_hub_private_subnet_cidr_block
  public_subnet_cidr_block                = var.backup_nonprod_hub_public_subnet_cidr_block

  create_master_encryption_key = var.backup_nonprod_create_master_encryption_key
  enable_replication           = var.backup_nonprod_vault_enable_replication
  replica_region               = var.backup_nonprod_vault_replica_region
  resource_label               = var.resource_label
  security_compartment_id      = module.nonprod_environment.compartment.security.id
  vault_type                   = var.backup_nonprod_vault_type
  home_compartment_id          = module.home_compartment.compartment_id

  depends_on = [module.nonprod_environment]

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}