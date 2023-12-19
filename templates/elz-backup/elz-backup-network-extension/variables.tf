##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# Common Variables
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}
variable "backup_region" {
  type        = string
  description = "Name of the backup region"
}

variable "environment_prefix" {
  type        = string
  description = ""
}

variable "home_compartment_id" {
  type        = string
  description = "Home Compartment ID"
}

variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT."
}

# VPN Variables
variable "enable_vpn_on_environment" {
  type = bool
}

variable "cpe_display_name" {
  type = string
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment (CPE) IP address"
}

variable "network_compartment_id" {
  type = string
}

variable "ipsec_connection_static_routes" {
  type = list(string)
}

variable "ipsec_display_name" {
  type = string
}

variable "drg_id" {
  type = string
}

variable "cpe_vendor" {
  type = number
}

variable "routing" {
  type        = string
  description = ""
}

variable "tunnel_a_display_name" {
  type = string
}

variable "customer_bgp_asn" {
  type = string
}

variable "bgp_cust_tunnela_ip" {
  type = string
}

variable "bgp_oci_tunnela_ip" {
  type = string
}

variable "shared_secret" {
  type = string
}

variable "tunnel_b_display_name" {
  type = string
}

# Fastconnect Variables
variable "fastconnect_provider" {
  type = string
}

variable "region_key" {
  type = string
}

variable "virtual_circuit_bandwidth_shape" {
  type = string
}

variable "virtual_circuit_display_name" {
  type = string
}

variable "provider_service_key_name" {
  type = string
}

variable "fastconnect_routing_policy" {
  type = list(string)
}

variable "virtual_circuit_type" {
  type = string
}

variable "customer_primary_bgp_peering_ip" {
  type = string
}

variable "oracle_primary_bgp_peering_ip" {
  type = string
}

variable "customer_secondary_bgp_peering_ip" {
  type = string
}

variable "oracle_secondary_bgp_peering_ip" {
  type = string
}

variable "virtual_circuit_customer_asn" {
  type = string
}

variable "virtual_circuit_is_bfd_enabled" {
  type = bool
}

variable "bgp_md5auth_key" {
  type = string
}

variable "enable_fastconnect_on_environment" {
  type = bool
}

variable "remote_peering_connection_peer_id" {
  type    = string
  default = null
}

variable "remote_peering_connection_peer_region_name" {
  type    = string
  default = null
}

variable "drg_route_table_rpc_id" {
  type    = string
}

variable "drg_route_table_vc_id" {
  type    = string
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
}
