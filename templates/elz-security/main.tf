##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

locals {
  cloud_guard = {
    display_name                               = "${var.resource_label}-OCI-ELZ-CG-${var.environment_prefix}"
    status                                     = "ENABLED"
    target_resource_type                       = "COMPARTMENT"
    description                                = "OCI LZ Cloud Guard Target"
    configuration_detector_recipe_display_name = "OCI Configuration Detector Recipe"
    activity_detector_recipe_display_name      = "OCI Activity Detector Recipe"
    threat_detector_recipe_display_name        = "OCI Threat Detector Recipe"
    responder_recipe_display_name              = "OCI Responder Recipe"
  }

  vss = {
    host_scan_recipe_display_name              = "${var.resource_label}-OCI-ELZ-VSS-${var.environment_prefix}"
    host_scan_target_display_name              = "${var.resource_label}-OCI-ELZ-VSS-Target-${var.environment_prefix}"
    host_scan_recipe_agent_settings_scan_level = "STANDARD"
    host_scan_recipe_port_settings_scan_level  = "STANDARD"
    agent_cis_benchmark_settings_scan_level    = "STRICT"
    vss_scan_schedule                          = "DAILY"
  }

  vault = {
    name = "${var.resource_label}-OCI-ELZ-VAL-${var.environment_prefix}"
  }

  key = {
    name = "${var.resource_label}-OCI-ELZ-KEY-${var.environment_prefix}"
    shape_algorithm = "AES"
    shape_length = 32
    protection_mode = "SOFTWARE"
  }

  create_key = var.vault_type != "NONE" && var.create_master_encryption_key

  key_policy = {
    name        = "${var.resource_label}-OCI-ELZ-KEY-Policy-${var.environment_prefix}"
    description = "OCI Enterprise Landing Zone Key Policy"

    statements = local.create_key ? [
      "Allow service objectstorage-${var.region} to use keys in compartment id ${var.security_compartment_id} where target.key.id = ${module.key[0].key_ocid}",
      "Allow service blockstorage,FssOc1Prod, OKE, streaming to use keys in compartment id ${var.security_compartment_id} where target.key.id = ${module.key[0].key_ocid}"
    ] : []
  }

}

module "cloud_guard" {
  source = "../../modules/cloud-guard"
  count                                      = var.enable_cloud_guard ? 1 : 0
  
  tenancy_ocid                               = var.tenancy_ocid
  region                                     = var.region
  status                                     = local.cloud_guard.status
  compartment_id                             = var.environment_compartment_id
  display_name                               = local.cloud_guard.display_name
  target_resource_id                         = var.environment_compartment_id
  target_resource_type                       = local.cloud_guard.target_resource_type
  description                                = local.cloud_guard.description
  configuration_detector_recipe_display_name = local.cloud_guard.configuration_detector_recipe_display_name
  activity_detector_recipe_display_name      = local.cloud_guard.activity_detector_recipe_display_name
  threat_detector_recipe_display_name        = local.cloud_guard.threat_detector_recipe_display_name
  responder_recipe_display_name              = local.cloud_guard.responder_recipe_display_name

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

module "vss" {
  source                                     = "../../modules/vss"
  recipe_compartment_ocid                    = var.security_compartment_id
  target_compartment_ocid                    = var.environment_compartment_id
  host_scan_recipe_agent_settings_scan_level = local.vss.host_scan_recipe_agent_settings_scan_level
  host_scan_recipe_port_settings_scan_level  = local.vss.host_scan_recipe_port_settings_scan_level
  agent_cis_benchmark_settings_scan_level    = local.vss.agent_cis_benchmark_settings_scan_level
  vss_scan_schedule                          = local.vss.vss_scan_schedule
  host_scan_recipe_display_name              = local.vss.host_scan_recipe_display_name
  host_scan_target_display_name              = local.vss.host_scan_target_display_name
}

module "vault" {
  source             = "../../modules/vault"
  # vault_type = "NONE" is used for testing. 
  count              = var.vault_type != "NONE" ? 1 : 0 
  compartment_id     = var.security_compartment_id
  display_name       = local.vault.name
  vault_type         = var.vault_type
  replica_region     = var.replica_region
  enable_replication = var.enable_replication
}

module "key" {
  source              = "../../modules/key"
  count               = local.create_key ? 1 : 0
  compartment_ocid    = var.security_compartment_id
  display_name        = local.key.name
  shape_algorithm     = local.key.shape_algorithm
  shape_length        = local.key.shape_length
  protection_mode     = local.key.protection_mode
  management_endpoint = module.vault[0].management_endpoint

  depends_on = [module.vault]
}

module "key_policy" {
  source              = "../../modules/policies"
  count               = local.create_key ? 1 : 0
  compartment_ocid    = var.home_compartment_id
  description         = local.key_policy.description
  policy_name         = local.key_policy.name
  statements          = local.key_policy.statements
}