output "management_endpoint" {
  value       = oci_kms_vault.vault.management_endpoint
  description = "The endpoint OCID of the valut"
}