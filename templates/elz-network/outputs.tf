output "subnets" {
  value = {
    (oci_core_subnet.hub_public_subnet.display_name) = oci_core_subnet.hub_public_subnet.id
    (oci_core_subnet.hub_private_subnet.display_name) = oci_core_subnet.hub_private_subnet.id
    (oci_core_subnet.spoke_app_subnet.display_name) = oci_core_subnet.spoke_app_subnet.id
    (oci_core_subnet.spoke_web_subnet.display_name) = oci_core_subnet.spoke_web_subnet.id
    (oci_core_subnet.spoke_db_subnet.display_name) = oci_core_subnet.spoke_db_subnet.id
  }
  description = "The subnet OCID"
}
output "vcn" {
  value = oci_core_vcn.vcn_hub_network
}

output "spoke_web_subnet_ocid" {
  value = oci_core_subnet.spoke_web_subnet.id
}

output "drg_id" {
  value = module.drg.drg_id
}

output "drg_route_tables" {
 value =  module.drg.drg_route_tables
}