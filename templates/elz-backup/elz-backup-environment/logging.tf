module "logging" {
  source                              = "../elz-backup-logging"
  region                              = var.backup_region
  environment_prefix                  = var.environment_prefix
  tenancy_ocid                        = var.tenancy_ocid
  security_compartment_id             = var.security_compartment_id
  master_encryption_key               = module.security.key_id
  logging_compartment_id              = var.logging_compartment_id
  resource_label                      = var.resource_label
  retention_policy_duration_amount    = var.retention_policy_duration_amount
  retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
  home_compartment_name               = var.home_compartment_name
  home_compartment_id                 = var.home_compartment_id
  subnets_map                         = module.backup-network.subnets
  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }

  depends_on = [ module.security ]
}