##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

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

  vss = {
    host_scan_recipe_display_name              = "${var.resource_label}-OCI-ELZ-VSS-${var.environment_prefix}-BACKUP-${local.region_key[0]}"
    host_scan_target_display_name              = "${var.resource_label}-OCI-ELZ-VSS-Target-${var.environment_prefix}-BACKUP-${local.region_key[0]}"
    host_scan_recipe_agent_settings_scan_level = "STANDARD"
    host_scan_recipe_port_settings_scan_level  = "STANDARD"
    agent_cis_benchmark_settings_scan_level    = "STRICT"
    vss_scan_schedule                          = "DAILY"
  }

  bastion = {
    name = "${var.resource_label}-OCI-ELZ-BAS-${var.environment_prefix}-BACKUP-${local.region_key[0]}"
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

module "vss" {
  source                                     = "../../../modules/vss"
  recipe_compartment_ocid                    = var.security_compartment_id
  target_compartment_ocid                    = var.environment_compartment_id
  host_scan_recipe_agent_settings_scan_level = local.vss.host_scan_recipe_agent_settings_scan_level
  host_scan_recipe_port_settings_scan_level  = local.vss.host_scan_recipe_port_settings_scan_level
  agent_cis_benchmark_settings_scan_level    = local.vss.agent_cis_benchmark_settings_scan_level
  vss_scan_schedule                          = local.vss.vss_scan_schedule
  host_scan_recipe_display_name              = local.vss.host_scan_recipe_display_name
  host_scan_target_display_name              = local.vss.host_scan_target_display_name

  providers = {
    oci = oci.backup_region
  }
}

module "bastion" {
  source                               = "../../../modules/bastion"
  target_subnet_id                     = var.bastion_target_subnet_id
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  bastion_name                         = local.bastion.name
  compartment_id                       = var.security_compartment_id

  providers = {
    oci = oci.backup_region
  }
}