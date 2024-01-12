##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "drg_id" {
  value = module.drg_backup.drg_id
  description = "DRG OCID."
}

output "vcn_id" {
  value = oci_core_vcn.vcn_hub_network_backup.id
  description = "Hub VCN OCID."
}

output "subnets" {
  value = {
    (var.hub_public_subnet_display_name)  = oci_core_subnet.hub_public_subnet_backup.id
    (var.hub_private_subnet_display_name) = oci_core_subnet.hub_private_subnet_backup.id
  }
  description = "The Hub Subnet OCIDs"
}

output "oci_network_firewall_ip_address" {
  value = try(data.oci_core_private_ips.firewall_subnet_private_ip.private_ips[0].id,null)
  description = "Network Firewall IP OCID."
}

output "service_gateway_value" {
      value = data.oci_core_services.service-gateway
}