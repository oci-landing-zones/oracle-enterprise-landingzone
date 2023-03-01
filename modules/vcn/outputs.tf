output "vcn_id" {
  value       = oci_core_vcn.vcn.id
  description = "The OCID of the VCN created"
}

output "vcn" {
  value = oci_core_vcn.vcn
}

