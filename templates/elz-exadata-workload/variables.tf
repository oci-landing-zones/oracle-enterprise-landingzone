##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

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

variable "resource_label" {
  type        = string
  default     = ""
  description = "A prefix used to avoid naming conflicts if multiple Landing Zones are deployed."
}

variable "db_port" {
  type        = number
  description = "Database Port. Default 1521."
  default     = 1521
}

variable "enable_fan_events" {
  type        = bool
  description = "Security List to be enabled for ONS FAN events"
  default     = true
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
}

# -----------------------------------------------------------------------------
# IAM Variables
# -----------------------------------------------------------------------------

variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

variable "environment_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment was created."
}

variable "environment_compartment_name" {
  type        = string
  description = "the name of the compartment where the environment was created."
  default     = ""
}

variable "workload_name" {
  type        = string
  description = "The name of the workload that is using Exadata."
  default     = "Exadata"
}

variable "workload_prefix" {
  type        = string
  description = "Atleast 4 Alphanumeric Charater to Describe the Workload : WRK1"
}

variable "workload_compartment_name" {
  type        = string
  description = "The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>."
  default     = ""
}

variable "workload_admin_group_name" {
  type        = string
  description = "the name of workload admin group"
  default     = ""
}

variable "application_admin_group_name" {
  type        = string
  description = "the name of workload application admin group"
  default     = ""
}

variable "exadata_infra_admin_group_name" {
  type        = string
  description = "the name of exadata infrastructure admin group"
  default     = ""
}

variable "database_admin_group_name" {
  type        = string
  description = "the name of workload database admin group"
  default     = ""
}

variable "enable_datasafe" {
  type        = bool
  description = "Enable DataSafe related IAM Group and Policies"
  default     = false
}

variable "datasafe_admin_group_name" {
  type        = string
  description = "the name of datasafe admin group"
  default     = ""
}

variable "datasafe_reports_group_name" {
  type        = string
  description = "the name of datasafe reports group"
  default     = ""
}

variable "network_admin_group_name" {
  type        = string
  description = "the name of landing zone Network admin group"
  default     = ""
}

variable "network_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "security_compartment_name" {
  type        = string
  description = "security compartment name under shared infra compartment"
  default     = ""
}

variable "security_compartment_id" {
  type        = string
  description = "the OCID of the security compartment."
}

variable "security_admin_group_name" {
  type        = string
  description = "the name of landing zone Security admin group"
  default     = ""
}

variable "identity_domain_id" {
  type        = string
  description = "the ocid of identity domain"
  default     = "ocid1.domain."
  validation {
    condition     = can(regex("^domain$", split(".", var.identity_domain_id)[1]))
    error_message = "Only Domain OCID is allowed."
  }
}

variable "identity_domain_name" {
  type        = string
  description = "identity domain name"
  default     = ""
}

# -----------------------------------------------------------------------------
# Network Variables
# -----------------------------------------------------------------------------

variable "workload_spoke_vcn_cidr" {
  description = "IPv4 CIDR blocks the VCN will use."
  type        = string
}

variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "spokelabel"
  validation {
    condition     = length(var.vcn_dns_label) < 16
    error_message = "DNS Label : Max 15 alphanumeric characters allowed."
  }
}

variable "vcn_display_name" {
  type        = string
  description = "Workload Expansion Spoke VCN Display Name"
  default     = ""
}

variable "enable_nat_gateway_spoke" {
  type = bool
}

variable "workload_private_spoke_subnet_lb_display_name" {
  type        = string
  description = "Workload Expansion Spoke LB Subnet Display Name."
  default     = ""
}

variable "workload_private_spoke_subnet_app_display_name" {
  type        = string
  description = "Workload Expansion Spoke App Subnet Display Name."
  default     = ""
}

variable "workload_private_spoke_subnet_client_display_name" {
  type        = string
  description = "Workload Expansion Spoke Client Subnet Display Name."
  default     = ""
}

variable "workload_private_spoke_subnet_backup_display_name" {
  type        = string
  description = "Workload Expansion Spoke Backup Subnet Display Name."
  default     = ""
}

variable "workload_private_spoke_subnet_lb_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke LB CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_lb_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke App CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_app_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_private_spoke_subnet_client_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke Client CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_client_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_private_spoke_subnet_backup_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke Backup CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_backup_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_private_spoke_subnet_lb_dns_label" {
  description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "lbdnslabel"
  validation {
    condition     = length(var.workload_private_spoke_subnet_lb_dns_label) < 16
    error_message = "DNS Label : Max 15 alphanumeric characters allowed."
  }
}

variable "workload_private_spoke_subnet_app_dns_label" {
  description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "appdnslabel"
  validation {
    condition     = length(var.workload_private_spoke_subnet_app_dns_label) < 16
    error_message = "DNS Label : Max 15 alphanumeric characters allowed."
  }
}

variable "workload_private_spoke_subnet_client_dns_label" {
  description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "clientdnslabel"
  validation {
    condition     = length(var.workload_private_spoke_subnet_client_dns_label) < 16
    error_message = "DNS Label : Max 15 alphanumeric characters allowed."
  }
}

variable "workload_private_spoke_subnet_backup_dns_label" {
  description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
  default     = "backupdnslabel"
  validation {
    condition     = length(var.workload_private_spoke_subnet_backup_dns_label) < 16
    error_message = "DNS Label : Max 15 alphanumeric characters allowed."
  }
}

variable "nat_gateway_display_name" {
  description = "(Updatable) Name of NAT Gateway. Does not have to be unique."
  type        = string
  default     = "ngw"
}

variable "service_gateway_display_name" {
  description = "(Updatable) Name of Service Gateway. Does not have to be unique."
  type        = string
  default     = "sgw"
}

variable "nat_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "service_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "route_table_display_name" {
  type        = string
  description = "Workload Expansion Spoke Route Table Name Disply Name."
  default     = ""
}

variable "security_list_display_name" {
  type        = string
  description = "Workload Expansion Spoke Security List Name Disly Name."
  default     = ""
}

variable "drg_id" {
  type = string
  validation {
    condition     = can(regex("^drg$", split(".", var.drg_id)[1]))
    error_message = "Only Compartment OCID is allowed."
  }
}

variable "hub_vcn_id" {
  description = "OCID of Hub VCN."
  type        = string
}

variable "hub_vcn_cidr_block" {
  description = "CIDR of Hub VCN."
  type        = string
}

variable "hub_public_subnet_cidr_block" {
  type    = string
  default = "10.1.1.0/24"
  validation {
    condition     = can(cidrhost(var.hub_public_subnet_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "hub_private_subnet_cidr_block" {
  type    = string
  default = "10.1.2.0/24"
  validation {
    condition     = can(cidrhost(var.hub_private_subnet_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "customer_onprem_ip_cidr" {
  type    = list(string)
  default = []
}

variable "enable_vpn_on_environment" {
  type    = bool
  default = false
}

variable "enable_vpn_or_fastconnect" {
  type    = string
  default = "NONE"
}

variable "ipsec_connection_static_routes" {
  type    = list(string)
  default = [""]
}

# -----------------------------------------------------------------------------
# Security Variables
# -----------------------------------------------------------------------------

variable "enable_bastion" {
  type        = bool
  description = "Option to enable bastion service"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}

# -----------------------------------------------------------------------------
# Logging Variables
# -----------------------------------------------------------------------------

variable "default_log_group_id" {
  type        = string
  description = "Default Log Group ID"
}

# -----------------------------------------------------------------------------
# Monitoring Variables
# -----------------------------------------------------------------------------

variable "is_create_alarms" {
  type        = bool
  description = "Enable Alarms Creation in all Compartment"
  default     = true
}

variable "enable_workload_monitoring_alarms" {
  type        = bool
  description = "Enable Workload Monitoring Alarms in Workload Compartment"
  default     = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_workload_monitoring_alarms))
    error_message = "The workload_expansion_flag variable must be either true or false."
  }
}

variable "workload_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Workload notifications."
  validation {
    condition = length(
      [for e in var.workload_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.workload_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}
