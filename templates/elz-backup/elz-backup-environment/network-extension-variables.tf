##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT."
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment (CPE) IP address"
  default     = ""
}

variable "ipsec_connection_static_routes" {
  type = list(string)
  default     = [ null ]
}

variable "enable_vpn_on_environment" {
  type = bool
  default     = false
}

variable "cpe_display_name" {
  type = string
  default     = ""
}

variable "ipsec_display_name" {
  type = string
  default     = ""
}

variable "cpe_vendor" {
  type = number
  default     = 0
}

variable "routing" {
  type        = string
  description = ""
  default     = ""
}

variable "tunnel_a_display_name" {
  description = "Tunnel A display name. Recommendation: "
  default     = ""
}

variable "customer_bgp_asn" {default     = ""}

variable "bgp_cust_tunnela_ip" {default     = ""}

variable "bgp_oci_tunnela_ip" {default     = ""}

variable "shared_secret" {default     = "example"}

variable "tunnel_b_display_name" {default     = ""}

# Fastconnect Variables
variable "fastconnect_provider" {
  type = string
  default     = ""
}

variable "region_key" {
  type = string
}

variable "virtual_circuit_bandwidth_shape" {
  type = string
  default     = "1500"

}

variable "virtual_circuit_display_name" {
  type = string
  default     = ""
}

variable "provider_service_key_name" {
  type = string
  default     = ""
}

variable "fastconnect_routing_policy" {
  type = list(string)
  default     = []
}

variable "virtual_circuit_type" {
  type = string
  default     = ""
}

variable "customer_primary_bgp_peering_ip" {
  type = string
  default     = ""
}

variable "oracle_primary_bgp_peering_ip" {
  type = string
  default     = ""
}

variable "customer_secondary_bgp_peering_ip" {
  type = string
  default     = ""
}

variable "oracle_secondary_bgp_peering_ip" {
  type = string
  default     = ""
}

variable "virtual_circuit_customer_asn" {
  type = string
  default     = 0
}

variable "virtual_circuit_is_bfd_enabled" {
  type = bool
  default     = false
}

variable "bgp_md5auth_key" {
  type = string
  default     = ""
}

variable "enable_fastconnect_on_environment" {
  type = bool
  default     = true
}

variable "remote_peering_connection_peer_id" {
  type    = string
  default = null
}

variable "remote_peering_connection_peer_region_name" {
  type    = string
  default = null
}

variable "customer_onprem_ip_cidr" {
  type    = list(string)
  default = []
}
