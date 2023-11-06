module "security" {
  source = "../elz-backup-security"

  backup_region                = var.backup_region
  create_master_encryption_key = var.create_master_encryption_key
  enable_replication           = var.enable_replication
  environment_prefix           = var.environment_prefix
  replica_region               = var.replica_region
  resource_label               = var.resource_label
  security_compartment_id      = var.security_compartment_id
  tenancy_ocid                 = var.tenancy_ocid
  vault_type                   = var.vault_type

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}