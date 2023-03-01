output "compartment_id" {
  value       = oci_identity_compartment.compartment.id
  description = "The OCID of the compartment created"
  depends_on = [
    time_sleep.compartment_replication_delay
  ]
}

