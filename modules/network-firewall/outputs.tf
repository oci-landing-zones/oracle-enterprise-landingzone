##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "firewall_id" {
  value       = oci_network_firewall_network_firewall.network_firewall.id
  description = "The OCID of network firewall"
}

output "firewall_ip_id" {
  value       = data.oci_core_private_ips.firewall_subnet_private_ip.private_ips[0].id
  description = "The OCID of network firewall ip"
}

output "firewall_ip" {
  value       = oci_network_firewall_network_firewall.network_firewall.ipv4address
  description = "The IP address network firewall"
}