locals {
  vault = {
    name = "${var.resource_label}-OCI-ELZ-VAL-${var.environment_prefix}-BACKUP-${local.region_key[0]}"
  }

  key = {
    name = "${var.resource_label}-OCI-ELZ-KEY-${var.environment_prefix}-BACKUP-${local.region_key[0]}"
    shape_algorithm = "AES"
    shape_length = 32
    protection_mode = "SOFTWARE"
  }

  create_key = var.vault_type != "NONE" && var.create_master_encryption_key

  key_policy = {
    name        = "${var.resource_label}-OCI-ELZ-KEY-Policy-${var.environment_prefix}-BACKUP-${local.region_key[0]}"
    description = "OCI Enterprise Landing Zone Key Policy For Backup Region"

    statements = local.create_key ? [
      "Allow service objectstorage-${var.backup_region} to use keys in compartment id ${var.security_compartment_id}",
      "Allow service blockstorage,FssOc1Prod, OKE, streaming to use keys in compartment id ${var.security_compartment_id}"
    ] : []
  }
}

module "vault" {
  source             = "../../../modules/vault"
  # vault_type = "NONE" is used for testing.
  count              = var.vault_type != "NONE" ? 1 : 0
  compartment_id     = var.security_compartment_id
  display_name       = local.vault.name
  vault_type         = var.vault_type
  replica_region     = var.replica_region
  enable_replication = var.enable_replication

  providers = {
    oci = oci.backup_region
  }
}

module "key" {
  source              = "../../../modules/key"
  count               = local.create_key ? 1 : 0
  compartment_ocid    = var.security_compartment_id
  display_name        = local.key.name
  shape_algorithm     = local.key.shape_algorithm
  shape_length        = local.key.shape_length
  protection_mode     = local.key.protection_mode
  management_endpoint = module.vault[0].management_endpoint

  providers = {
    oci = oci.backup_region
  }

  depends_on = [module.vault]
}

module "key_policy" {
  source              = "../../../modules/policies"
  count               = local.create_key ? 1 : 0
  compartment_ocid    = var.home_compartment_id
  description         = local.key_policy.description
  policy_name         = local.key_policy.name
  statements          = local.key_policy.statements
}