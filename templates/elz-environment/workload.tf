# -----------------------------------------------------------------------------
# Workload Resources 
# -----------------------------------------------------------------------------
locals {
  workload = {
    workload_name             = "Workload1"
    enable_compartment_delete = true
  }
}

module "workload" {
  source = "../elz-workload"

  tenancy_ocid                 = var.tenancy_ocid
  region                       = var.region
  environment_prefix           = var.environment_prefix

  workload_name                = local.workload.workload_name
  enable_compartment_delete    = local.workload.enable_compartment_delete
  environment_compartment_id   = module.compartment.compartments.environment.id
  security_compartment_id      = module.compartment.compartments.security.id
  network_compartment_id       = module.compartment.compartments.network.id

  security_compartment_name    = module.compartment.compartments.security.name
  identity_domain_id           = module.identity.domain.id
  identity_domain_name         = module.identity.domain.display_name
  workload_admin_group_name    = var.workload_admin_group_name
  application_admin_group_name = var.application_admin_group_name
  database_admin_group_name    = var.database_admin_group_name

  is_create_alarms         = var.is_create_alarms
  enable_security_monitoring_alarms = var.enable_security_monitoring_alarms
  enable_network_monitoring_alarms  = var.enable_network_monitoring_alarms
  enable_workload_monitoring_alarms = var.enable_workload_monitoring_alarms

  customer_onprem_ip_cidr                      = var.customer_onprem_ip_cidr
  drg_id                                       = module.network.drg_id
  enable_vpn_on_environment                    = var.enable_vpn_on_environment
  enable_vpn_or_fastconnect                    = var.enable_vpn_or_fastconnect
  ipsec_connection_static_routes               = var.ipsec_connection_static_routes
  workload_private_spoke_subnet_app_cidr_block = var.private_spoke_subnet_app_cidr_block
  workload_private_spoke_subnet_db_cidr_block  = var.private_spoke_subnet_db_cidr_block
  workload_private_spoke_subnet_web_cidr_block = var.private_spoke_subnet_web_cidr_block
  workload_spoke_vcn_cidr                      = var.spoke_vcn_cidr
  

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
