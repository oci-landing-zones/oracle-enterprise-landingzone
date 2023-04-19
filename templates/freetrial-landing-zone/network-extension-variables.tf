variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT."
  default     = "NONE"
}

variable "prod_enable_vpn" {
  type        = bool
  description = "Enable VPN in prod environment"
  default     = false
}

variable "prod_cpe_display_name" {
  type        = string
  description = "Customer Premises Equipment name. Recommendation: OCI-ELZ-CPE-[Environment]-HUB-[Region] 001"
  default     = ""
}

variable "prod_cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment (CPE) IP address"
  default     = ""
}
variable "prod_ipsec_display_name" {
  type        = string
  description = "IPsec display name. Recommendation: OCI-ELZ-IPS-[Environment]-HUB-[Region] 001"
  default     = ""
}
variable "prod_ipsec_connection_static_routes" {
  type        = list(string)
  description = ""
  default     = [""]
}
variable "prod_cpe_vendor" {
  type        = number
  description = "Type corresponding number as your CPE vendor: Yamaha-RTX1210 0, Other 1, Cisco-9.7.1-or-later 2, Yamaha-RTX830 3, Libreswan 4, Fortinet 5, NEC 6, Cisco-8.5+ 7, Cisco-IOS 8, WatchGuard 9, Juniper-MX 10, Juniper-SRX 11, Furukawa 12, Check_Point 13, Palo_Alto 14"
  default     = 0
}

variable "prod_ipsec_routing_type" {
  type        = string
  description = "BGP dynamic routing, STATIC routing. Type BGP or STATIC"
  default     = "STATIC"
}

variable "prod_tunnel_a_display_name" {
  type        = string
  description = "Tunnel A display name. Recommendation: "
  default     = ""
}

variable "prod_customer_bgp_asn" {
  type        = string
  description = "ASN is required and used for the tunnel's BGP session"
  default     = ""
}

variable "prod_bgp_cust_tunnela_ip" {
  type        = string
  description = "The IP address for the CPE end of the inside tunnel interface."
  default     = ""
}

variable "prod_bgp_oci_tunnela_ip" {
  type        = string
  description = "The IP address for the Oracle end of the inside tunnel interface."
  default     = ""

}

variable "prod_shared_secret" {
  type        = string
  description = "The shared secret (pre-shared key) to use for the IPSec tunnel"
  default     = "example"

}

variable "prod_tunnel_b_display_name" {
  type        = string
  description = "Tunnel B display name. Recommendation: "
  default     = ""
}
# Fastconnect Variables
variable "fastconnect_provider" {
  type        = string
  description = "Fastconnect provider. Please choose from: AT&T, Azure, Megaport, QTS, CEintro, Cologix, CoreSite, Digitial Realty, EdgeConneX, Epsilon, Equinix, InterCloud, Lumen, Neutrona, OMCS, OracleL2ItegDeployment, OracleL3ItegDeployment, Orange, Verizon, Zayo"
  default     = ""
}


variable "virtual_circuit_bandwidth_shape" {
  type        = string
  description = "The provisioned data rate of the connection"
  default     = "1500"
}

variable "virtual_circuit_display_name" {
  type        = string
  description = "The display name of this virtual circuit. Recommendation: OCI-ELZ-FCN-P-HUB-[REGION] 001"
  default     = ""
}

variable "provider_service_key_name" {
  type        = string
  description = "The provider service key that the provider gives you when you set up a virtual circuit connection from the provider to OCI"
  default     = ""
}

variable "fastconnect_routing_policy" {
  type        = list(string)
  description = "Available FastConnect routing policies: ORACLE_SERVICE_NETWORK, REGIONAL, MARKET_LEVEL, GLOBAL"
  default     = []
}

variable "virtual_circuit_type" {
  type        = string
  description = "The type of IP addresses used in this virtual circuit. PRIVATE or PUBLIC"
  default     = ""
}

variable "customer_primary_bgp_peering_ip" {
  type        = string
  description = "The primary BGP IPv4 address of the customer's router"
  default     = ""

}

variable "oracle_primary_bgp_peering_ip" {
  type        = string
  description = "The primary BGP IPv4 address for Oracle's end of the BGP session"
  default     = ""
}

variable "customer_secondary_bgp_peering_ip" {
  type        = string
  description = "[Optional] The secondary BGP IPv4 address of the customer's router"
  default     = ""
}

variable "oracle_secondary_bgp_peering_ip" {
  type        = string
  description = "[Optional] Secondary IPv4 address for Oracle's end of the BGP session"
  default     = ""
}

variable "virtual_circuit_customer_asn" {
  type        = string
  description = "The BGP ASN of the network at the other end of the BGP session from Oracle"
  default     = 0
}

variable "virtual_circuit_is_bfd_enabled" {
  type        = bool
  description = "Set to true to enable BFD for IPv4 BGP peering, or set to false to disable BFD"
  default     = false
}

variable "bgp_md5auth_key" {
  type        = string
  description = "The key for BGP MD5 authentication. Only applicable if your system requires MD5 authentication"
  default     = ""
}

variable "prod_enable_fastconnect" {
  type        = bool
  default     = true
  description = "[Please don't change this value] Enable fastconnect in prod environment."
}
variable "customer_onprem_ip_cidr" {
  type    = list(string)
  default = []
}
