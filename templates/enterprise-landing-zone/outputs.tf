##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "subnets" {
  value       = module.prod_environment.subnets
  description = "The Subnet OCID."
}

output "vcn" {
  value = module.prod_environment.vcn
  description = "Production Environment VCN Information."
}

output "dynamic_group_detail" {
  value = module.osms_dynamic_group
  description = "OSMS Dynamic Group OCID."
}


output "workload_compartment_id" {
  value = module.prod_environment.workload_compartment_id
  description = "Workload Compartment OCID."
}

output "prod_environment" {
  value = {
    environment_prefix          = local.prod_environment.environment_prefix
    compartments                = module.prod_environment.compartment
    subnets                     = module.prod_environment.subnets
    hub_vcn                     = module.prod_environment.vcn
    hub_public_subnet_cidr      = module.prod_environment.hub_public_subnet_cidr
    hub_private_subnet_cidr     = module.prod_environment.hub_private_subnet_cidr
    drg_id                      = module.prod_environment.drg_id
    identity_domain             = module.prod_environment.identity_domain
    workload_compartment_name   = module.prod_environment.workload_compartment_name
    workload_compartment_id     = module.prod_environment.workload_compartment_id
    workload_subnet_cidr_blocks = module.prod_environment.workload_subnet_cidr_blocks
    access_governance_service_instance = module.prod_environment.access_governance_service_instance
  }
  description = "Production Environment Information."
}

output "nonprod_environment" {
  value = {
    environment_prefix          = local.nonprod_environment.environment_prefix
    compartments                = try(module.nonprod_environment[0].compartment, null)
    subnets                     = try(module.nonprod_environment[0].subnets, null)
    hub_vcn                     = try(module.nonprod_environment[0].vcn, null)
    hub_public_subnet_cidr      = try(module.nonprod_environment[0].hub_public_subnet_cidr, null)
    hub_private_subnet_cidr     = try(module.nonprod_environment[0].hub_private_subnet_cidr, null)
    drg_id                      = try(module.nonprod_environment[0].drg_id, null)
    identity_domain             = try(module.nonprod_environment[0].identity_domain, null)
    workload_compartment_name   = try(module.nonprod_environment[0].workload_compartment_name, null)
    workload_compartment_id     = try(module.nonprod_environment[0].workload_compartment_id, null)
    workload_subnet_cidr_blocks = try(module.nonprod_environment[0].workload_subnet_cidr_blocks, null)
    access_governance_service_instance = try(module.nonprod_environment[0].access_governance_service_instance, null)
  }
  description = "Non-Production Environment Information."
}