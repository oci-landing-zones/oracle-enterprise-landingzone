output "drg_id" {
  value = module.drg.drg_id
}

output "vcn_id" {
  value = oci_core_vcn.vcn_hub_network.id
}

output "subnets" {
  value = {
    (oci_core_subnet.hub_public_subnet.display_name)  = oci_core_subnet.hub_public_subnet.id
    (oci_core_subnet.hub_private_subnet.display_name) = oci_core_subnet.hub_private_subnet.id
  }
  description = "The subnet OCID"
}

output "spoke_drg_route_table_id" {
  value = var.enable_network_firewall ? module.drg.drg_route_tables["RT-Spoke"].id : null
}

output "hub_drg_route_distribution" {
  value = var.enable_network_firewall ? module.drg.drg_route_distributions["Import-Hub"].id : null
}