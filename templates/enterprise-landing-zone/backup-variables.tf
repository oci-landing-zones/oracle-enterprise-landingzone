variable "backup_region" {
  type        = string
  description = "Backup region for the landing zone"
}

variable "enable_landing_zone_replication" {
  type        = bool
  default     = false
  description = "True if landing zone is to be replicated"
}

variable "backup_prod_workload_cidr" {
  type        = string
  description = "Workload cidr for backup region in prod environment"
  default     = "10.6.0.0/16"
}

variable "backup_nonprod_workload_cidr" {
  type        = string
  description = "Workload cidr for backup region in non-prod environment"
  default     = "10.7.0.0/16"
}


variable "backup_prod_enable_nat_gateway_spoke" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
variable "backup_prod_enable_service_gateway_spoke" {
  default     = true
  type        = bool
  description = "Option to enable spoke service gateway for backup region in prod"

}
variable "backup_prod_enable_vpn" {
  default     = false
  type        = bool
  description = "Option to enable VPN for backup region in prod"
}
variable "backup_enable_vpn_or_fastconnect" {
  default     = "NONE"
  type        = string
  description = "Option to enable VPN or FastConnect for backup region"
}
variable "backup_nonprod_enable_nat_gateway_spoke" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in non-prod"

}
variable "backup_nonprod_enable_service_gateway_spoke" {
  default     = true
  type        = bool
  description = "Option to enable spoke service gateway for backup region in non-prod"

}
variable "backup_nonprod_enable_vpn" {
  default     = false
  type        = bool
  description = "Option to enable VPN for backup region in non-prod"

}




###############################################################################
############               Network Variable                      ##############
###############################################################################

variable "backup_enable_vpn_or_fastconnect" {
  type        = string
  description = "Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT."
  default     = "NONE"
}

variable "backup_customer_onprem_ip_cidr" {
  type    = list(string)
  default = [ null ]
}

##PROD
variable "backup_prod_enable_internet_gateway_hub" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
variable "backup_prod_enable_nat_gateway_hub" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
variable "backup_prod_enable_service_gateway_hub" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
#backup_prod_hub_vcn_cidr_block

variable "backup_prod_hub_public_subnet_cidr_block" {
  default     = "10.8.1.0/24"
  type        = string
  description = "Hub public subnet CIDR block for backup region in prod"
}

variable "backup_nonprod_hub_private_subnet_cidr_block" {
  default     = "10.9.1.0/24"
  type        = string
  description = "Hub public subnet CIDR block for backup region in non-prod"

}
variable "backup_prod_spoke_subnet_app_cidr_block" {
  default     = "10.6.1.0/24"
  type        = string
  description = "Spoke App subnet CIDR block for backup region in prod"
}
variable "backup_prod_spoke_subnet_db_cidr_block" {
  default     = "10.6.2.0/24"
  type        = string
  description = "Spoke Database subnet CIDR block for backup region in prod"
}
variable "backup_prod_spoke_subnet_web_cidr_block" {
  default     = "10.6.3.0/24"
  type        = string
  description = "Spoke Web subnet CIDR block for backup region in prod"
}

variable "backup_prod_ipsec_connection_static_routes" {
  default     = [null]
  type        = list(string)
  description = "IPsec connection static routes for backup region in prod"
}

variable "backup_prod_enable_vpn" {
  type        = bool
  description = "Enable VPN in prod environment"
  default     = false
}

variable "backup_prod_enable_fastconnect" {
  type        = bool
  default     = true
  description = "[Please don't change this value] Enable fastconnect in prod environment."
}

variable "backup_prod_additional_workload_subnets_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack in prod for backup region"
}

variable "backup_enable_network_firewall_prod" {
  type        = string
  description = "Enable Network Firewall in Prod Enviornment."
  default     = "false"
}

variable "backup_enable_traffic_threat_log_prod" {
  type        = bool
  description = "Enable Network Firewall Threat and Traffic Logs in Prod Enviornment."
  default     = false
}

variable "backup_nfw_subnet_type_prod" {
  type        = string
  description = "Network Firewall Subnet Type."
  default     = "public"
}

variable "backup_nfw_instance_name_prod" {
  type        = string
  description = "Network Firewall Instance Name."
  default     = ""
}
variable "backup_nfw_instance_policy_prod" {
  type        = string
  description = "Network Firewall Instance Policy Name."
  default     = ""
}

variable "backup_nfw_use_existing_network_prod" {
  type        = bool
  description = "Use Existing VCN in place of Network Firewall VCN."
  default     = false
}

####NONPROD

variable "backup_nonprod_enable_internet_gateway_hub" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
variable "backup_nonprod_enable_nat_gateway_hub" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
variable "backup_nonprod_enable_service_gateway_hub" {
  default     = true
  type        = bool
  description = "Option to enable spoke NAT gateway for backup region in prod"
}
variable "backup_prod_hub_private_subnet_cidr_block" {
  default     = "10.8.2.0/24"
  type        = string
  description = "Hub private subnet CIDR block for backup region in prod"
}

variable "backup_nonprod_hub_public_subnet_cidr_block" {
  default     = "10.9.2.0/24"
  type        = string
  description = "Hub private subnet CIDR block for backup region in non-prod"

}

variable "backup_nonprod_spoke_subnet_app_cidr_block" {
  default     = "10.7.1.0/24"
  type        = string
  description = "Spoke App subnet CIDR block for backup region in non-prod"

}
variable "backup_nonprod_spoke_subnet_db_cidr_block" {
  default     = "10.7.2.0/24"
  type        = string
  description = "Spoke Database subnet CIDR block for backup region in non-prod"

}
variable "backup_nonprod_spoke_subnet_web_cidr_block" {
  default     = "10.7.3.0/24"
  type        = string
  description = "Spoke Web subnet CIDR block for backup region in non-prod"

}
variable "backup_prod_ipsec_connection_static_routes" {
  default     = [null]
  type        = list(string)
  description = "IPsec connection static routes for backup region in prod"
}
variable "backup_nonprod_enable_vpn" {
  type        = bool
  description = "Enable VPN in non prod environment"
  default     = false
}
variable "backup_nonprod_enable_fastconnect" {
  type        = bool
  default     = false
  description = "[Please don't change this value] Enable fastconnect in non prod environment."
}
variable "backup_nonprod_additional_workload_subnets_cidr_blocks" {
  default     = []
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack in non-prod for backup region"
}

variable "backup_enable_network_firewall_nonprod" {
  type        = string
  description = "Enable Network Firewall in Non-Prod Enviornment."
  default     = "false"
}

variable "backup_enable_traffic_threat_log_nonprod" {
  type        = bool
  description = "Enable Network Firewall Threat and Traffic Logs in Non-Prod Enviornment."
  default     = false
}
variable "backup_nfw_subnet_type_nonprod" {
  type        = string
  description = "Network Firewall Subnet Type."
  default     = "public"
}

variable "backup_nfw_instance_name_nonprod" {
  type        = string
  description = "Network Firewall Instance Name."
  default     = ""
}

variable "backup_nfw_instance_policy_nonprod" {
  type        = string
  description = "Network Firewall Instance Policy Name."
  default     = ""
}

variable "backup_nfw_use_existing_network_nonprod" {
  type        = bool
  description = "Use Existing VCN in place of Network Firewall VCN."
  default     = false
}

# -----------------------------------------------------------------------------
# Security Variables
# -----------------------------------------------------------------------------
variable "backup_prod_create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key in prod for backup region"
  default     = true
}

variable "backup_prod_vault_enable_replication" {
  type        = bool
  description = "Option to enable vault replication in prod for backup region"
  default     = false
}

variable "backup_prod_vault_replica_region" {
  type        = string
  description = "the region to be created replica to. Required *if* prod_enable_vault_replication is true."
  default     = ""
}

variable "backup_prod_vault_type" {
  type        = string
  description = "The type of vault to create in prod for backup region. "
  default     = "DEFAULT"
}

variable "backup_nonprod_create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key in nonprod for backup region"
  default     = true
}

variable "backup_nonprod_vault_enable_replication" {
  type        = bool
  description = "Option to enable vault replication in nonprod for backup region"
  default     = false
}

variable "backup_nonprod_vault_replica_region" {
  type        = string
  description = "the region to be created replica to. Required *if* nonprod_enable_vault_replication is true."
  default     = ""
}

variable "backup_nonprod_vault_type" {
  type        = string
  description = "The type of vault to create in nonprod for backup region. "
  default     = "DEFAULT"
}