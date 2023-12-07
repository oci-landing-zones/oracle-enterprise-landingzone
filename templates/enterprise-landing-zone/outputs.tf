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
    compartments                = module.nonprod_environment.compartment
    subnets                     = module.nonprod_environment.subnets
    hub_vcn                     = module.nonprod_environment.vcn
    hub_public_subnet_cidr      = module.nonprod_environment.hub_public_subnet_cidr
    hub_private_subnet_cidr     = module.nonprod_environment.hub_private_subnet_cidr
    drg_id                      = module.nonprod_environment.drg_id
    identity_domain             = module.nonprod_environment.identity_domain
    workload_compartment_name   = module.nonprod_environment.workload_compartment_name
    workload_compartment_id     = module.nonprod_environment.workload_compartment_id
    workload_subnet_cidr_blocks = module.nonprod_environment.workload_subnet_cidr_blocks
    access_governance_service_instance = module.nonprod_environment.access_governance_service_instance
  }
  description = "Non-Production Environment Information."
}