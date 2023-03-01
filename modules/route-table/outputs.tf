output "id" {
  value       = oci_core_route_table.route_table[0].id
  description = "The OCID of the route table"
}
