variable "compartment_ocid" {
  type        = string
  description = ""
}

variable "cpe_ip_address" {
  type        = string
  description = "Customer Premises Equipment IP address"
}

variable "cpe_display_name" {
  type        = string
  description = "Customer Premises Equipment IP address"
}

variable "ipsec_display_name" {
  type        = string
  description = ""
}

variable "drg_id" {
  type        = string
  description = ""
}

variable "static_routes" {
  type        = list(string)
}

variable "cpe_vendor" {
  type        = number
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