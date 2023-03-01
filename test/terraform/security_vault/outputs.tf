output "environment_compartment_id" {
  value       = module.environment_compartment.compartment_id
  description = "The OCID of the test environment compartment"
}

output "security_compartment_id" {
  value       = module.security_compartment.compartment_id
  description = "The OCID of the test security compartment"
}

output "key_id" {
  value  = module.security.key_id
  description = "OCID of Master Encryption Key."
}