output "environment_compartment_id" {
  value       = module.environment_compartment.compartment_id
  description = "The OCID of the test environment compartment"
}

output "security_compartment_id" {
  value       = module.security_compartment.compartment_id
  description = "The OCID of the test security compartment"
}
