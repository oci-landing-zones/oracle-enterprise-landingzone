output "security_list_id" {
  value       = oci_core_security_list.security_list_spoke.id
  description = "The OCID of the Security List"
}
