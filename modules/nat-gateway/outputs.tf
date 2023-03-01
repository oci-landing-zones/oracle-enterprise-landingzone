output "nat_gw_id" {
  value = oci_core_nat_gateway.OCI-ELZ-NGW-P-HUB.id
  description = "NAT Gateway OCID."
}
