##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

module "security" {
  source = "../elz-backup-security"

  backup_region                        = var.backup_region
  create_master_encryption_key         = var.create_master_encryption_key
  enable_replication                   = var.enable_replication
  environment_prefix                   = var.environment_prefix
  replica_region                       = var.replica_region
  resource_label                       = var.resource_label
  security_compartment_id              = var.security_compartment_id
  tenancy_ocid                         = var.tenancy_ocid
  vault_type                           = var.vault_type
  home_compartment_id                  = var.home_compartment_id
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  bastion_target_subnet_id             = module.network.spoke_web_subnet_ocid
  environment_compartment_id           = var.environment_compartment_id

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }

}