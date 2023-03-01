output "service_gw_id" {
  value = oci_core_service_gateway.service_gateway_all_svcs.id
  description = "Service Gateway OCID."
}
