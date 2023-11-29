##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "enable_network_firewall_prod" {
  type        = string
  description = "Enable Network Firewall in Prod Enviornment."
  default     = "false"
}
variable "enable_network_firewall_nonprod" {
  type        = string
  description = "Enable Network Firewall in Non-Prod Enviornment."
  default     = "false"
}

#enable_traffic_threat_log

variable "enable_traffic_threat_log_prod" {
  type        = bool
  description = "Enable Network Firewall Threat and Traffic Logs in Prod Enviornment."
  default     = false
}

variable "enable_traffic_threat_log_nonprod" {
  type        = bool
  description = "Enable Network Firewall Threat and Traffic Logs in Non-Prod Enviornment."
  default     = false
}

#enable_nfw_subnet_type

variable "nfw_subnet_type_prod" {
  type        = string
  description = "Network Firewall Subnet Type."
  default     = "public"
}
variable "nfw_subnet_type_nonprod" {
  type        = string
  description = "Network Firewall Subnet Type."
  default     = "public"
}

variable "nfw_instance_name_prod" {
  type        = string
  description = "Network Firewall Instance Name."
  default     = ""
}
variable "nfw_instance_name_nonprod" {
  type        = string
  description = "Network Firewall Instance Name."
  default     = ""
}

variable "nfw_instance_policy_prod" {
  type        = string
  description = "Network Firewall Instance Policy Name."
  default     = ""
}
variable "nfw_instance_policy_nonprod" {
  type        = string
  description = "Network Firewall Instance Policy Name."
  default     = ""
}

variable "nfw_use_existing_network_prod" {
  type        = bool
  description = "Use Existing VCN in place of Network Firewall VCN."
  default     = false
}
variable "nfw_use_existing_network_nonprod" {
  type        = bool
  description = "Use Existing VCN in place of Network Firewall VCN."
  default     = false
}

