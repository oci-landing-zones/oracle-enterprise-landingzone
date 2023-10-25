


module "backup_prod_environment" {
  source = "../elz-backup-environment"
  workload_spoke_vcn_cidr = var.backup_prod_workload_cidr
  workload_compartment_id = module.prod_environment.workload_compartment_id

  providers = {
    oci             = oci
    oci.backup_region = oci.backup_region
  }


}

module "backup_nonprod_environment" {
  source = "../elz-backup-environment"

  workload_spoke_vcn_cidr = var.backup_nonprod_workload_cidr
  workload_compartment_id = module.nonprod_environment.workload_compartment_id


  providers = {
    oci             = oci
    oci.backup_region = oci.backup_region
  }
}