
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

}