##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "workload_compartment_id" {
  type        = string
  description = "WorkLoad Compartment OCID"
}

variable "spoke_vcn_cidr" {
  type        = string
  description = "Spoke:VCN CIDR Block."
}

variable "backup_region" {
  type        = string
  description = "Name of the backup region"
}
variable "region" {
  type        = string
  description = "Name of the backup region"
}
variable "tenancy_ocid" {
  type        = string
  description = "OCID of the home tenancy"
}
#variable "customer_onprem_ip_cidr" {
#  type        = list(string)
#  description = "IP CIDR for from customer onprem side"
#}
variable "enable_nat_gateway_spoke" {
  type        = bool
  description = "Option to enable NAT gateway in Spoke"
}
variable "enable_service_gateway_spoke" {
  type        = bool
  description = "Option to enable service gateway in Spoke"
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
  default     = false
}

#
variable "network_compartment_id" {
  type        = string
  description = "Network Compartment OCID"
}

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
  default = [""]
}

variable "nat_gw_hub_check" {
  type = list(string)
  default = [""]
}

variable "service_gw_hub_check" {
  type = list(string)
  default = [""]
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
variable "add_ssh_to_security_list" {
  type        = bool
  description = "Add SSH tcp port to Hub security list"
  default     = false
}
variable "private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Spoke App subnet CIDR block"
}
variable "private_spoke_subnet_db_cidr_block" {
  type        = string
  description = "Spoke Database subnet CIDR block"
}
variable "private_spoke_subnet_web_cidr_block" {
  type        = string
  description = "Spoke Web subnet CIDR block"
}

#variable "ipsec_connection_static_routes" {
#  type        = list(string)
#  description = "IPsec connection static routes for backup region "
#}

#variable "enable_vpn_on_environment" {
#  type        = bool
#  description = "Option to enable VPN on environment level"
#}
#variable "enable_vpn_or_fastconnect" {
#  type        = string
#  description = "Option to enable VPN or FastConnect"
#}
#variable "enable_fastconnect_on_environment" {
#  type = bool
#}
variable "additional_workload_subnets_cidr_blocks" {
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack for backup region"
  default     = []
}

variable "enable_network_firewall" {
  type        = string
  description = "Enable Network Firewall in Prod Enviornment."
  default     = "false"
}
variable "enable_traffic_threat_log" {
  type        = bool
  description = "Enable Network Firewall Threat and Traffic Logs in Prod Enviornment."
  default     = false
}
variable "nfw_subnet_type" {
  type        = string
  description = "Network Firewall Subnet Type."
  default     = "public"
}
variable "nfw_instance_name" {
  type        = string
  description = "Network Firewall Instance Name."
  default     = ""
}
variable "nfw_instance_policy" {
  type        = string
  description = "Network Firewall Instance Policy Name."
  default     = ""
}
variable "nfw_use_existing_network" {
  type        = bool
  description = "Use Existing VCN in place of Network Firewall VCN."
  default     = false
}
#variable "log_group_id" {
#  type        = string
#  description = "Log Group OCID."
#}
