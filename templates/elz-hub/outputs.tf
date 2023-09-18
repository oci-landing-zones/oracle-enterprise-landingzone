output "drg_id" {
  value = module.drg.drg_id
}

output "vcn_id" {
  value = oci_core_vcn.vcn_hub_network.id
}

output "subnets" {
  value = {
    (var.hub_public_subnet_display_name)  = oci_core_subnet.hub_public_subnet.id
    (var.hub_private_subnet_display_name) = oci_core_subnet.hub_private_subnet.id
  }
  description = "The Hub Subnet OCIDs"
}
