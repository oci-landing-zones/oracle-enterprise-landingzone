output "route_table_id" {
  value       = oci_core_route_table.route_table.id
  description = "The OCID of the route table"
}

output "sgw_id" {
  value       = oci_core_service_gateway.sgw.id
  description = "The OCID of the service gateway"
}
