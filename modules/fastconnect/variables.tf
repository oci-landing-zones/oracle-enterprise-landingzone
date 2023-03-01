variable "fastconnect_asn_provider_list" {
  type        = string
  description = "Providers that require customer asn"
  default     = "Megaport,QTS,C3ntro,Cologix,CoreSite,Digital Realty,EdgeConneX,Epsilon,Equinix,InterCloud,Lumen,Neutrona,OracleL2ItegDeployment,Zayo"
}

variable "fastconnect_no_asn_provider_list" {
  type        = string
  description = "Providers that don't require customer asn or peering ip"
  default     = "AT&T,Verizon,BT,OMCS,OracleL3ItegDeployment,Orange"
}

variable "fastconnect_provider" {
  type = string
}

variable "compartment_ocid" {
  type = string
}

variable "drg_id" {
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

variable "drg_route_table_vc_id" {
  type = string
}