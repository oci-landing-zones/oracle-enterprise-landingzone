##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "home_compartment_id" {
  type        = string
  description = "Home Compartment ID"
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
}
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}
variable "backup_region" {
  type        = string
  description = "Name of the backup region"
}
# -----------------------------------------------------------------------------
# Network Variables
# -----------------------------------------------------------------------------
variable "enable_internet_gateway_hub" {
  type        = string
  default     = "false"
  description = "Option to enable true and Disable false."
}
variable "enable_nat_gateway_hub" {
  type        = string
  default     = "false"
  description = "Option to enable true and Disable false."
}

variable "enable_service_gateway_hub" {
  type        = string
  default     = "false"
  description = "Option to enable true and Disable false."
}

variable "igw_hub_check" {
  type = list(string)
}

variable "nat_gw_hub_check" {
  type = list(string)
}

variable "service_gw_hub_check" {
  type = list(string)
}

variable "network_compartment_id" {
  type        = string
  description = "Network Compartment OCID"
}

variable "vcn_cidr_block" {
  type        = string
  description = "VCN CIDR Block."
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Hub: Public Subnet CIDR Block."
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "Hub: Private Subnet CIDR Block."
}

variable "private_spoke_subnet_web_cidr_block" {
  type        = string
  description = "Spoke: Private Subnet Web CIDR Block."
}

variable "private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Spoke: Private Subnet App CIDR Block-1."
}

variable "private_spoke_subnet_db_cidr_block" {
  type        = string
  description = "Spoke: Private Subnet DB CIDR Block-1."
}

variable "add_ssh_to_security_list" {
  type        = bool
  description = "Add SSH tcp port to Hub security list"
  default     = false
}

variable "hub_vcn_name" {
  type        = string
  description = "Hub VCN Name."
}
variable "hub_vcn_dns_label" {
  type        = string
  description = "Hub VCN DNS Label."
}
variable "hub_public_subnet_display_name" {
  type        = string
  description = "Hub Public Subnet Display Name."
}
variable "hub_public_subnet_description" {
  type        = string
  description = "Hub Public Subnet Description."
}
variable "hub_public_subnet_dns_label" {
  type        = string
  description = "Hub Public Subnet DNS Label."
}
variable "hub_private_subnet_display_name" {
  type        = string
  description = "Hub Private Subnet Name."
}
variable "hub_private_subnet_description" {
  type        = string
  description = "Hub Private Subnet Description."
}
variable "hub_private_subnet_dns_label" {
  type        = string
  description = "Hub Private Subnet DNS Label."
}
variable "igw_gateway_display_name" {
  type        = string
  description = "Hub Internet Gateway Display Name."
}
variable "nat_gateway_display_name" {
  type        = string
  description = "Hub NAT Gateway Display Name.."
}
variable "srv_gateway_display_name" {
  type        = string
  description = "Hub Service Gateway Display Name."
}
variable "hub_security_list_display_name" {
  type        = string
  description = "Hub Security List Display Name."
}

# -----------------------------------------------------------------------------
# Network Extension Variables
# -----------------------------------------------------------------------------
variable "ipsec_connection_static_routes" {
  type = list(string)
}

variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT."
}

variable "enable_vpn_on_environment" {
  type = bool
}

variable "enable_fastconnect_on_environment" {
  type = bool
}

variable "customer_onprem_ip_cidr" {
  type = list(string)
}

# -----------------------------------------------------------------------------
# Workload Network Variables
# -----------------------------------------------------------------------------
variable "additional_workload_subnets_cidr_blocks" {
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack"
}

# -----------------------------------------------------------------------------
# Network Firewall Variables
# -----------------------------------------------------------------------------

variable "enable_network_firewall" {
  type        = bool
  description = "Enable Network Firewall in Enviornment."
}
variable "enable_traffic_threat_log" {
  type        = bool
  description = "Enable Traffic & Threat Log on Network Firewall."
}
variable "nfw_use_existing_network" {
  type        = bool
  description = "Use Existing VCN instead of Network Firewall."
}
variable "nfw_instance_name" {
  type        = string
  description = "Network Firewall Instance Name."
}
variable "nfw_instance_policy" {
  type        = string
  description = "Network Firewall Policy Name."
}
variable "log_group_id" {
  type        = string
  description = "Log Group OCID."
}
variable "nfw_subnet_type" {
  type        = string
  description = "Network Firewall Subnet Type : Public or Private Subnet."
}
# -----------------------------------------------------------------------------
# Network Firewall Variables
# -----------------------------------------------------------------------------

