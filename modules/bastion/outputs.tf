output "bastion_ocid" {
  value       = oci_bastion_bastion.bastion.id
  description = "The OCID of the bastion created  "
}