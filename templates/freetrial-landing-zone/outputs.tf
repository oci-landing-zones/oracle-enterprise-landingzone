output "subnets" {
  value       = module.prod_environment.subnets
  description = "The subnet OCID"
}

output "vcn" {
  value = module.prod_environment.vcn
}

output "dynamic_group_detail" {
  value = module.osms_dynamic_group
}

output "workload_compartment_id" {
  value = module.prod_environment.workload_compartment_id
}