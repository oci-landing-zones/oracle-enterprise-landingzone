##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "backup_region" {
  type        = string
  description = "Backup region for the landing zone"
}

variable "enable_landing_zone_replication" {
  type        = bool
  default     = false
  description = "True if landing zone is to be replicated"
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
#variable "home_compartment_name" {
#  type        = string
#  default     = "OCI-ELZ-CMP-HOME"
##  description = "The name of the Landing Zone home compartment."
#}
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
variable "backup_igw_hub_check" {
  type    = list(string)
  default = [""]
}
variable "backup_nat_gw_hub_check" {
  type    = list(string)
  default = [""]
}
variable "backup_service_gw_hub_check" {
  type    = list(string)
  default = [""]
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

variable "backup_prod_hub_vcn_cidr_block" {
  default     = "10.5.0.0/16"
  type        = string
  description = "Back Hub VCN CIDR Block"
}
variable "backup_prod_public_subnet_cidr_block" {
  default     = "10.5.1.0/24"
  type        = string
  description = "Back Hub VCN Public Subnet CIDR Block"
}
variable "backup_prod_private_subnet_cidr_block" {
  default     = "10.5.2.0/24"
  type        = string
  description = "Back Hub VCN Private Subnet CIDR Block"
}
variable "backup_prod_workload_cidr" {
  default     = "10.6.0.0/16"
  type        = string
  description = "Back Spoke VCN CIDR Block"
}
variable "backup_prod_spoke_subnet_web_cidr_block" {
  default     = "10.6.1.0/24"
  type        = string
  description = "Back Spoke VCN Subnet Web CIDR Block"
}
variable "backup_prod_spoke_subnet_app_cidr_block" {
  default     = "10.6.2.0/24"
  type        = string
  description = "Back Spoke VCN Subnet App CIDR Block"
}
variable "backup_prod_spoke_subnet_db_cidr_block" {
  default     = "10.6.2.0/24"
  type        = string
  description = "Back Spoke VCN Subnet DB CIDR Block"
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

variable "backup_nonprod_hub_vcn_cidr_block" {
  default     = "10.5.0.0/16"
  type        = string
  description = "Back Hub VCN CIDR Block"
}
variable "backup_nonprod_public_subnet_cidr_block" {
  default     = "10.5.1.0/24"
  type        = string
  description = "Back Hub VCN Public Subnet CIDR Block"
}
variable "backup_nonprod_private_subnet_cidr_block" {
  default     = "10.5.2.0/24"
  type        = string
  description = "Back Hub VCN Private Subnet CIDR Block"
}
variable "backup_nonprod_workload_cidr" {
  default     = "10.6.0.0/16"
  type        = string
  description = "Back Spoke VCN CIDR Block"
}
variable "backup_nonprod_spoke_subnet_web_cidr_block" {
  default     = "10.6.1.0/24"
  type        = string
  description = "Back Spoke VCN Subnet Web CIDR Block"
}
variable "backup_nonprod_spoke_subnet_app_cidr_block" {
  default     = "10.6.2.0/24"
  type        = string
  description = "Back Spoke VCN Subnet App CIDR Block"
}
variable "backup_nonprod_spoke_subnet_db_cidr_block" {
  default     = "10.6.2.0/24"
  type        = string
  description = "Back Spoke VCN Subnet DB CIDR Block"
}

variable "backup_nonprod_ipsec_connection_static_routes" {
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

variable "backup_prod_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "backup_prod_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "backup_nonprod_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "backup_nonprod_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "backup_nonprod_bastion_client_cidr_block_allow_list" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}

variable "backup_prod_bastion_client_cidr_block_allow_list" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}

#Monitoring

variable "is_create_alarms_backup" {
  type        = bool
  default     = true
  description = "Enable Alarms Creation in all Compartment"
}

variable "prod_network_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Network Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.prod_network_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_network_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_secops_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Secops Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.prod_secops_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_secops_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_platform_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Platform notifications."
  validation {
    condition = length(
      [for e in var.prod_platform_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_platform_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_identity_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Identity notifications."
  validation {
    condition = length(
      [for e in var.prod_identity_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_identity_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}
variable "nonprod_network_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Network Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.nonprod_network_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.nonprod_network_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "nonprod_secops_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Secops Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.nonprod_secops_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.nonprod_secops_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "nonprod_platform_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Platform notifications."
  validation {
    condition = length(
      [for e in var.nonprod_platform_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.nonprod_platform_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "nonprod_identity_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Identity notifications."
  validation {
    condition = length(
      [for e in var.nonprod_identity_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.nonprod_identity_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_workload_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Prod Workload notifications."
  validation {
    condition = length(
      [for e in var.prod_workload_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_workload_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}

variable "nonprod_workload_topic_endpoints_backup" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Non Prod Workload notifications."
  validation {
    condition = length(
      [for e in var.nonprod_workload_topic_endpoints_backup :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.nonprod_workload_topic_endpoints_backup)
    error_message = "Validation failed: invalid email address."
  }
}
variable "prod_enable_security_monitoring_alarms_backup" {
  type        = bool
  default     = false
  description = "Enable Security Monitoring Alarms in Production Security Compartment"
}
variable "prod_enable_network_monitoring_alarms_backup" {
  type        = bool
  default     = false
  description = "Enable Network Monitoring Alarms in Production Network Compartment"
}
variable "prod_enable_workload_monitoring_alarms_backup" {
  type        = bool
  default     = false
  description = "Enable Workload Monitoring Alarms in Production Workload Compartment"
}
variable "nonprod_enable_security_monitoring_alarms_backup" {
  type        = bool
  default     = false
  description = "Enable Security Monitoring Alarms in Non-Production Security Compartment"
}
variable "nonprod_enable_network_monitoring_alarms_backup" {
  type        = bool
  default     = false
  description = "Enable Network Monitoring Alarms in Non-Production Network Compartment"
}
variable "nonprod_enable_workload_monitoring_alarms_backup" {
  type        = bool
  default     = false
  description = "Enable Workload Monitoring Alarms in Non-Production Workload Compartment"
}