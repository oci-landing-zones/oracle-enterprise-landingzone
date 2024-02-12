##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# output "compartment_id" {
#   value       = module.workload_compartment.compartment_id
#   description = "The OCID of Exadata Workload Compartment"
# }
# output "compartment_name" {
#   value       = module.workload_compartment.compartment_name
#   description = "The Exadata Workload Compartment Name"
# }

# output "subnet_cidr_blocks" {
#   value = {
#     spoke_subnet_lb_cidr     = var.workload_private_spoke_subnet_lb_cidr_block
#     spoke_subnet_app_cidr    = var.workload_private_spoke_subnet_app_cidr_block
#     spoke_subnet_client_cidr = var.workload_private_spoke_subnet_client_cidr_block
#     spoke_subnet_backup_cidr = var.workload_private_spoke_subnet_backup_cidr_block
#   }
# }

# output "bastion_id" {
#   value = var.enable_bastion ? module.bastion[0].bastion_ocid : null
# }

output "workload" {
  value = {
    environment_prefix        = var.environment_prefix
    workload_compartment_name = local.workload_compartment.name
    workload_compartment_id   = module.workload_compartment.compartment_id
    spoke_vcn                 = module.exadata_workload_expansion_spoke.spoke_vcn
    subnets                   = module.exadata_workload_expansion_spoke.subnets
    bastion_id                = var.enable_bastion ? module.bastion[0].bastion_ocid : null
    workload_lb_cidr          = var.workload_private_spoke_subnet_lb_cidr_block
    workload_app_cidr         = var.workload_private_spoke_subnet_app_cidr_block
    workload_client_cidr      = var.workload_private_spoke_subnet_client_cidr_block
    workload_backup_cidr      = var.workload_private_spoke_subnet_backup_cidr_block
  }
}
