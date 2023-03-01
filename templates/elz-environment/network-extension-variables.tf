variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT."
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment (CPE) IP address"
}

variable "ipsec_connection_static_routes" {
  type = list(string)
}

variable "enable_vpn_on_environment" {
  type = bool
}

variable "cpe_display_name" {
  type = string
}

variable "ipsec_display_name" {
  type = string
}

variable "cpe_vendor" {
  type = number
}

variable "routing" {
  type        = string
  description = ""
}

variable "tunnel_a_display_name" {}

variable "customer_bgp_asn" {}

variable "bgp_cust_tunnela_ip" {}

variable "bgp_oci_tunnela_ip" {}

variable "shared_secret" {}

variable "tunnel_b_display_name" {}

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

variable "customer_onprem_ip_cidr" {
  type    = list(string)
  default = []
}
