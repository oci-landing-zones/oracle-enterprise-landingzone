
module "backup_prod_environment" {
  source = "../elz-backup-environment"

  count = enable_landing_zone_replication ? 1 : 0

  workload_spoke_vcn_cidr = var.backup_prod_workload_cidr
  workload_compartment_id = module.prod_environment.workload_compartment_id

  depends_on = [ module.prod_environment ]

  providers = {
    oci             = oci
    oci.backup_region = oci.backup_region
  }
}

module "backup_nonprod_environment" {
  source = "../elz-backup-environment"

  count = enable_landing_zone_replication ? 1 : 0

  workload_spoke_vcn_cidr = var.backup_nonprod_workload_cidr
  workload_compartment_id = module.nonprod_environment.workload_compartment_id

  depends_on = [ module.nonprod_environment ]

  providers = {
    oci             = oci
    oci.backup_region = oci.backup_region
  }
}