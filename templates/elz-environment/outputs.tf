##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "compartment" {
  value = module.compartment.compartments
}

output "subnets" {
  value = module.network.subnets
  description = "The subnet OCID"
}

output "vcn" {
  value = module.network.vcn
}

output "hub_public_subnet_cidr" {
  value = var.public_subnet_cidr_block
}

output "hub_private_subnet_cidr" {
  value = var.private_subnet_cidr_block
}

output "drg_id" {
  value = module.network.drg_id
}

output "identity_domain" {
  value = module.identity.domain
}

output "identity_idcs_endpoint" {
  value = module.identity.idcs_endpoint
}

output "workload_compartment_id" {
  value = module.workload.compartment_id
}

output "workload_compartment_name" {
  value = module.workload.compartment_name
}

output "workload_subnet_cidr_blocks" {
  value = [var.private_spoke_subnet_app_cidr_block,
           var.private_spoke_subnet_db_cidr_block,
           var.private_spoke_subnet_web_cidr_block,
  ]
}

output "stream_id" {
  value = module.logging.stream_id
}

output "key_id" {
  value = module.security.key_id
}

output "bucket" {
  value = module.logging.bucket
}

output "default_group_id" {
  value = module.logging.log_group_id
}

output "vault_id" {
  value = module.security.vault_id
}

output "rpc_id" {
  value = module.network-extension.rpc_id
}


