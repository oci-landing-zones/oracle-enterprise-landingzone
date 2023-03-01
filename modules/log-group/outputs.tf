output "log_group_id" {
  value       = oci_logging_log_group.log_group.id
  description = "The OCID of the log group created"
}
