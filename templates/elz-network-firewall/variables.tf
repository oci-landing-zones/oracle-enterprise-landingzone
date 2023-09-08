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
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
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
  description = "Enable Network Firewall Threat and Traffic Logs in Enviornment."
}
variable "nfw_subnet_type" {
  type        = string
  description = "Network Firewall Subnet Type."
}
variable "nfw_instance_name" {
  type        = string
  description = "Network Firewall Instance Name."
}
variable "nfw_instance_policy" {
  type        = string
  description = "Network Firewall Instance Policy Name."
}
variable "nfw_subnet_cidr_block" {
  type        = string
  description = "Network Firewall Subnet CIDR IP Block."
}

