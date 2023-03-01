output "key_ocid" {
  value       = oci_kms_key.key.id
  description = "The OCID of the key created"
}