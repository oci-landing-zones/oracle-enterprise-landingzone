output "internet_gw_id" {
  value       = join(",", oci_core_internet_gateway.internet_gw[*].id)
  description = "Internet Gateway OCID Value."
}
output "nat_gw_id" {
  value       = join(",", oci_core_nat_gateway.nat_gw[*].id)
  description = "NAT Gateway OCID Value."
}
output "service_gw_id" {
  value       = join(",", oci_core_service_gateway.service_gw[*].id)
  description = "Service Gateway OCID Value."
}

