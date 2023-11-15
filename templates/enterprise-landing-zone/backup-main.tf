
module "backup_prod_environment" {
  source = "../elz-backup/elz-backup-environment"

  count = var.enable_landing_zone_replication ? 1 : 0

  environment_prefix      = local.prod_environment.environment_prefix
  spoke_vcn_cidr          = var.backup_prod_workload_cidr
  workload_compartment_id = module.prod_environment.workload_compartment_id
  backup_region           = var.backup_region
  tenancy_ocid            = var.tenancy_ocid

  enable_internet_gateway_hub             = var.backup_prod_enable_internet_gateway_hub
  enable_nat_gateway_hub                  = var.backup_prod_enable_nat_gateway_hub
  enable_service_gateway_hub              = var.backup_prod_enable_service_gateway_hub
  igw_hub_check                           = var.backup_igw_hub_check
  nat_gw_hub_check                        = var.backup_nat_gw_hub_check
  service_gw_hub_check                    = var.backup_service_gw_hub_check
  network_compartment_id                  = module.prod_environment.compartment.network.id
  vcn_cidr_block                          = var.backup_prod_hub_vcn_cidr_block
  public_subnet_cidr_block                = var.backup_prod_public_subnet_cidr_block
  private_subnet_cidr_block               = var.backup_prod_private_subnet_cidr_block
  private_spoke_subnet_web_cidr_block     = var.backup_prod_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block     = var.backup_prod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.backup_prod_spoke_subnet_db_cidr_block
  #add_ssh_to_security_list                = var.backup_prod_add_ssh_to_security_list
  ipsec_connection_static_routes          = var.backup_prod_ipsec_connection_static_routes
  enable_vpn_or_fastconnect               = var.backup_enable_vpn_or_fastconnect
  enable_vpn_on_environment               = var.backup_prod_enable_vpn
  enable_fastconnect_on_environment       = var.backup_prod_enable_fastconnect
  customer_onprem_ip_cidr                 = var.backup_customer_onprem_ip_cidr
  additional_workload_subnets_cidr_blocks = var.backup_prod_additional_workload_subnets_cidr_blocks
  is_baseline_deploy                      = var.is_baseline_deploy

  enable_network_firewall                 = var.backup_enable_network_firewall_prod
  enable_traffic_threat_log               = var.backup_enable_traffic_threat_log_prod
  nfw_subnet_type                         = var.backup_nfw_subnet_type_prod
  nfw_instance_name                       = var.backup_nfw_instance_name_prod
  nfw_instance_policy                     = var.backup_nfw_instance_policy_prod
  nfw_use_existing_network                = var.backup_nfw_use_existing_network_prod
  //TO DO 
  #log_group_id                            = module.prod_environment.default_log_group

  enable_nat_gateway_spoke                = var.backup_prod_enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.backup_prod_enable_service_gateway_spoke

  create_master_encryption_key = var.backup_prod_create_master_encryption_key
  enable_replication           = var.backup_prod_vault_enable_replication
  replica_region               = var.backup_prod_vault_replica_region
  resource_label               = var.resource_label
  security_compartment_id      = module.prod_environment.compartment.security.id
  vault_type                   = var.backup_prod_vault_type
  home_compartment_id          = module.home_compartment.compartment_id

  logging_compartment_id              = module.prod_environment.compartment.logging.id
  retention_policy_duration_amount    = var.backup_prod_retention_policy_duration_amount
  retention_policy_duration_time_unit = var.backup_prod_retention_policy_duration_time_unit

  bastion_client_cidr_block_allow_list = var.backup_prod_bastion_client_cidr_block_allow_list
  environment_compartment_id           = module.prod_environment.compartment.environment.id

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


  enable_internet_gateway_hub             = var.backup_nonprod_enable_internet_gateway_hub
  enable_nat_gateway_hub                  = var.backup_nonprod_enable_nat_gateway_hub
  enable_service_gateway_hub              = var.backup_nonprod_enable_service_gateway_hub
  igw_hub_check                           = var.backup_igw_hub_check
  nat_gw_hub_check                        = var.backup_nat_gw_hub_check
  service_gw_hub_check                    = var.backup_service_gw_hub_check
  network_compartment_id                  = module.nonprod_environment.compartment.network.id
  vcn_cidr_block                          = var.backup_nonprod_hub_vcn_cidr_block
  public_subnet_cidr_block                = var.backup_nonprod_public_subnet_cidr_block
  private_subnet_cidr_block               = var.backup_nonprod_private_subnet_cidr_block
  private_spoke_subnet_web_cidr_block     = var.backup_nonprod_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block     = var.backup_nonprod_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block      = var.backup_nonprod_spoke_subnet_db_cidr_block
  #add_ssh_to_security_list                = var.backup_nonprod_add_ssh_to_security_list
  ipsec_connection_static_routes          = var.backup_nonprod_ipsec_connection_static_routes
  enable_vpn_or_fastconnect               = var.backup_enable_vpn_or_fastconnect
  enable_vpn_on_environment               = var.backup_nonprod_enable_vpn
  enable_fastconnect_on_environment       = var.backup_nonprod_enable_fastconnect
  customer_onprem_ip_cidr                 = var.backup_customer_onprem_ip_cidr
  additional_workload_subnets_cidr_blocks = var.backup_nonprod_additional_workload_subnets_cidr_blocks
  is_baseline_deploy                      = var.is_baseline_deploy

  enable_network_firewall                 = var.backup_enable_network_firewall_nonprod
  enable_traffic_threat_log               = var.backup_enable_traffic_threat_log_nonprod
  nfw_subnet_type                         = var.backup_nfw_subnet_type_nonprod
  nfw_instance_name                       = var.backup_nfw_instance_name_nonprod
  nfw_instance_policy                     = var.backup_nfw_instance_policy_nonprod
  nfw_use_existing_network                = var.backup_nfw_use_existing_network_nonprod
  //TO DO 
  #log_group_id                            = module.nonprod_environment.default_log_group

  enable_nat_gateway_spoke                = var.backup_nonprod_enable_nat_gateway_spoke
  enable_service_gateway_spoke            = var.backup_nonprod_enable_service_gateway_spoke

  create_master_encryption_key = var.backup_nonprod_create_master_encryption_key
  enable_replication           = var.backup_nonprod_vault_enable_replication
  replica_region               = var.backup_nonprod_vault_replica_region
  resource_label               = var.resource_label
  security_compartment_id      = module.nonprod_environment.compartment.security.id
  vault_type                   = var.backup_nonprod_vault_type
  home_compartment_id          = module.home_compartment.compartment_id

  logging_compartment_id              = module.nonprod_environment.compartment.logging.id
  retention_policy_duration_amount    = var.backup_nonprod_retention_policy_duration_amount
  retention_policy_duration_time_unit = var.backup_nonprod_retention_policy_duration_time_unit

  bastion_client_cidr_block_allow_list = var.backup_nonprod_bastion_client_cidr_block_allow_list
  environment_compartment_id           = module.nonprod_environment.compartment.environment.id

  depends_on = [module.nonprod_environment]

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}