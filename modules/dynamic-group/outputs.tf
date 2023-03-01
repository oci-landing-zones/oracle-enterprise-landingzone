
output "id" {
  value       = oci_identity_dynamic_group.dynamic_group.id
  description = "The OCID of dynamic group created"
}

output "name" {
  value       = oci_identity_dynamic_group.dynamic_group.name
  description = "The name of dynamic group created"
}