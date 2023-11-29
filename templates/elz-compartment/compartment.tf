##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# -----------------------------------------------------------------------------
# Compartment Resources 
# -----------------------------------------------------------------------------
locals {
  environment_compartment = {
    name        = var.environment_compartment_name != "" ? var.environment_compartment_name : "OCI-ELZ-${var.environment_prefix}-CMP"
    description = "Environment Compartment"
  }

  shared_infra_compartment = {
    name        = "OCI-ELZ-${var.environment_prefix}-SRD-CMP-${local.region_key[0]}"
    description = "Shared environment Resources Compartment"
  }

  network_compartment = {
    name        = "OCI-ELZ-${var.environment_prefix}-SRD-NET"
    description = "Network Compartment"
  }

  security_compartment = {
    name        = "OCI-ELZ-${var.environment_prefix}-SRD-SEC"
    description = "Security Compartment"
  }

  logging_compartment = {
    name        = "OCI-ELZ-${var.environment_prefix}-LOG-${local.region_key[0]}"
    description = "Logging Compartment"
  }

  backup_compartment = {
    name        = "OCI-ELZ-${var.environment_prefix}-BAC-TF-${local.region_key[0]}"
    description = "Backup Compartment"
  }
}

module "environment_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = var.home_compartment_id
  compartment_name          = local.environment_compartment.name
  compartment_description   = local.environment_compartment.description
  enable_compartment_delete = var.enable_compartment_delete
  
  providers = {
    oci = oci.home_region
  }
}

module "shared_infra_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = local.shared_infra_compartment.name
  compartment_description   = local.shared_infra_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "network_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = module.shared_infra_compartment.compartment_id
  compartment_name          = local.network_compartment.name
  compartment_description   = local.network_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "security_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = module.shared_infra_compartment.compartment_id
  compartment_name          = local.security_compartment.name
  compartment_description   = local.security_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "logging_compartment" {
  source = "../../modules/compartment"

  count                     = var.enable_logging ? 1 : 0
  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = local.logging_compartment.name
  compartment_description   = local.logging_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "backup_compartment" {
  source = "../../modules/compartment"

  count                     = var.enable_tf_state_backup ? 1 : 0
  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = local.backup_compartment.name
  compartment_description   = local.backup_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

# @TODO copied from scca not sure if necessary here or for any others  
# - it seems the compartment technical module also has a delay so is this necessary?
resource "time_sleep" "compartment_replication_delay" {
  depends_on = [module.backup_compartment]

  create_duration = "90s"
}
