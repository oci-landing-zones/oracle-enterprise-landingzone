
module "backup_prod_environment" {
  source = "../elz-backup/elz-backup-environment"

  count = var.enable_landing_zone_replication ? 1 : 0

  environment_prefix      = local.prod_environment.environment_prefix
  spoke_vcn_cidr          = var.backup_prod_workload_cidr
  workload_compartment_id = module.prod_environment.workload_compartment_id
  backup_region           = var.backup_region
  tenancy_ocid            = var.tenancy_ocid

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

  depends_on = [module.nonprod_environment]

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}