##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "workload_compartment_id" {
  type = string
}

variable "vcn_display_name" {
  type        = string
  description = "Workload Expansion Spoke VCN Display Name"
}

variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
}

variable "workload_spoke_vcn_cidr" {
  description = "The list of IPv4 CIDR blocks the VCN will use."
  type        = string
}

variable "security_list_display_name" {
  type        = string
  description = "Display name for security list"
}

variable "route_table_display_name" {
  type        = string
  description = "Display name for route table"
}

variable "nat_gateway_display_name" {
  type        = string
  description = "Display name for NAT gateway"
}

variable "service_gateway_display_name" {
  type        = string
  description = "Display name for service gateway"
}

variable "enable_nat_gateway_spoke" {
  type        = bool
  description = "Option to enable NAT gateway in Spoke"
}
variable "nat_gw_spoke_check" {
  type    = list(string)
  default = [""]
}
variable "enable_service_gateway_spoke" {
  type        = bool
  description = "Option to enable service gateway in Spoke"
}
variable "service_gw_spoke_check" {
  type    = list(string)
  default = [""]
}
variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FastConnect"
}
variable "enable_vpn_on_environment" {
  type        = bool
  description = "Option to enable VPN on environment level"
}
variable "customer_onprem_ip_cidr" {
  type        = list(string)
  description = "IP CIDR block from customer onprem side"
}
variable "additional_workload_subnets_cidr_blocks" {
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack for backup region"
}
variable "ipsec_connection_static_routes" {
  type        = list(string)
  description = "IPsec connection static routes for backup region "

}
variable "drg_id" {
  type        = string
  description = "OCID of DRG from Hub"
}
variable "hub_public_subnet_cidr_block" {
  type        = string
  description = "Hub public subnet CIDR block"
}
variable "hub_private_subnet_cidr_block" {
  type        = string
  description = "Hub private subnet CIDR block"
}
variable "workload_private_spoke_subnet_web_display_name" {
  type        = string
  description = "Spoke Web subnet display name"
}
variable "workload_private_spoke_subnet_web_dns_label" {
  type        = string
  description = "Spoke Web subnet dns label"
}
variable "workload_private_spoke_subnet_web_cidr_block" {
  type        = string
  description = "Spoke Web subnet CIDR block"
}
variable "workload_private_spoke_subnet_app_display_name" {
  type        = string
  description = "Spoke APP subnet display name"
}
variable "workload_private_spoke_subnet_app_dns_label" {
  type        = string
  description = "Spoke APP subnet dns label"
}
variable "workload_private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Spoke APP subnet CIDR block"
}
variable "workload_private_spoke_subnet_db_display_name" {
  type        = string
  description = "Spoke Database subnet display name"
}
variable "workload_private_spoke_subnet_db_dns_label" {
  type        = string
  description = "Spoke Database subnet dns label"
}
variable "workload_private_spoke_subnet_db_cidr_block" {
  type        = string
  description = "Spoke Database subnet CIDR block"
}