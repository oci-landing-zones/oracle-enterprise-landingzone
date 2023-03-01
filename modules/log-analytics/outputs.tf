output "service_connector_id" {
  value = oci_sch_service_connector.service_connector.id
}

output "log_group_id" {
  value       = oci_log_analytics_log_analytics_log_group.log_analytics_log_group.id
  description = "The OCID of log group created"
}