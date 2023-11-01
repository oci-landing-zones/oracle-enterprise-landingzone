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

variable "tenancy_ocid" {
  type        = string
  description = "OCID of the home tenancy"
}

variable "additional_workload_subnets_cidr_blocks" {
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack for backup region"
}
variable "customer_onprem_ip_cidr" {
  type        = string
  description = "IP CIDR for from customer onprem side"
}
variable "enable_nat_gateway_spoke" {
  type        = bool
  description = "Option to enable NAT gateway in Spoke"
}
variable "enable_service_gateway_spoke" {
  type        = bool
  description = "Option to enable service gateway in Spoke"
}
variable "enable_vpn_on_environment" {
  type        = bool
  description = "Option to enable VPN on environment level"
}
variable "enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FastConnect"
}
variable "ipsec_connection_static_routes" {
  type        = list(string)
  description = "IPsec connection static routes for backup region "
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
variable "private_subnet_cidr_block" {
  type        = string
  description = "Hub private subnet CIDR block"
}
variable "public_subnet_cidr_block" {
  type        = string
  description = "Hub public subnet CIDR block"
}