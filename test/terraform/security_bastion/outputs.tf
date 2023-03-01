output "environment_compartment_id" {
  value       = module.environment_compartment.compartment_id
  description = "The OCID of the test environment compartment"
}

output "security_compartment_id" {
  value       = module.security_compartment.compartment_id
  description = "The OCID of the test security compartment"
}

output "test_subnet_id" {
    value = oci_core_subnet.test_subnet.id
    description = "OCID of test subnet"
}

output "bastion_id" {
  value = module.security.bastion_id
  description = "OCID of the created bastion"
}