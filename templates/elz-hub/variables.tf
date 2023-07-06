# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

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
  description = "TagNameSpace Optimization: Enable this flag to disble dependent module TagNameSpace Tag Creation."
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
  description = "Add SSH tcpp port to Hub security list"
  default     = false
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

