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
  description = "Prefix used to avoid naming conflict"
}
variable "workload_compartment_names" {
  type        = list(string)
  default     = []
  description = "The names of the workload compartments to update policies for the Admin Groups"
}
variable "is_baseline_deploy" {
  type        = bool
  description = "TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation."
}

# -----------------------------------------------------------------------------
# Compartment Variables
# -----------------------------------------------------------------------------
variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

variable "home_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}
#home_compartment_name

variable "home_compartment_name" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "environment_compartment_name" {
  type        = string
  description = "The name of the compartment that acts as the main compartment for the environment. Resources related to this environment will be created under this compartment. "
  default     = ""
}

variable "enable_tf_state_backup" {
  type        = bool
  description = "Set to true to enable logging compartment which contains the bucket for the log files."
  default     = false
}

variable "enable_logging" {
  type        = bool
  description = "Set to true to enable logging compartment which stores the configuration information that landing zones is setting up for the customer."
  default     = false
}

# -----------------------------------------------------------------------------
# IAM Variables
# -----------------------------------------------------------------------------
variable "domain_admin_email" {
  type        = string
  description = "The email address for the identity domain admin."
}

variable "network_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Network Administrators Group"
}

variable "security_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Security Administrators Group"
}

variable "iam_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone IAM Administrators Group"
}

variable "platform_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Platform Administrators Group"
}

variable "ops_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Ops Administrators Group"
}

variable "workload_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Workload Administrators Group"
}

variable "application_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Application Administrators Group"
}

variable "database_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Database Logging Administrators Group"
}
variable "domain_license_type" {
  type        = string
  description = "Identity Domain License Type"
}
# -----------------------------------------------------------------------------
# Budget Variables
# -----------------------------------------------------------------------------
variable "enable_budget" {

  type = bool
}

variable "budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  type        = string
  default     = ""
}

variable "budget_alert_rule_threshold" {
  description = "The threshold for the budget alert."
  type        = string
  default     = ""
}

variable "budget_alert_rule_message" {
  description = "The alert message for budget alerts."
  type        = string
  default     = ""
}

variable "budget_alert_rule_recipients" {
  description = "The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon"
  type        = string
  default     = ""
}

# -----------------------------------------------------------------------------
# Security Variables
# -----------------------------------------------------------------------------
variable "enable_cloud_guard" {
  type        = bool
  description = "true if you don't have cloud guard enabled, false if you've already have cloud guard enabled."
}

# -----------------------------------------------------------------------------
# Tagging Variables
# -----------------------------------------------------------------------------

variable "enable_tagging" {
  type        = bool
  description = "Set to true to enable Tagging."
  default     = false
}

variable "cost_center_tagging" {
  type        = string
  description = "Cost Center Varible"
}

variable "geo_location_tagging" {
  type        = string
  description = "Geo Location."
}

variable "enable_bastion" {
  type        = bool
  description = "Option to enable bastion service"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}

variable "vault_type" {
  type        = string
  description = "The type of vault to create. "
}

variable "vault_replica_region" {
  type        = string
  description = "the region to be created replica to."
}

variable "enable_vault_replication" {
  type        = bool
  description = "Option to enable vault replication"
}

variable "create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key"
}

# -----------------------------------------------------------------------------
# Network Variables
# -----------------------------------------------------------------------------

variable "hub_public_subnet_dns_label" {
  type        = string
  description = "Hub Public Subnet DNS Label."
}
variable "hub_private_subnet_dns_label" {
  type        = string
  description = "Hub Private Subnet DNS Label."
}
variable "subnet_app_dns_label" {
  type        = string
  description = "Spoke App Subnet DNS Label."
}
variable "subnet_db_dns_label" {
  type        = string
  description = "Spoke DB Subnet DNS Label."
}
variable "subnet_web_dns_label" {
  type        = string
  description = "Spoke Web Subnet DNS Label."
}

variable "enable_internet_gateway_hub" {
  type        = string
  description = "Option to enable true and Disable false."
}
variable "enable_nat_gateway_hub" {
  type        = string
  description = "Option to enable true and Disable false."
}

variable "enable_service_gateway_hub" {
  type        = string
  description = "Option to enable true and Disable false."
}

variable "enable_nat_gateway_spoke" {
  type        = string
  description = "Option to enable true and Disable false."
}

variable "enable_service_gateway_spoke" {
  type        = string
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

variable "nat_gw_spoke_check" {
  type = list(string)
}

variable "service_gw_spoke_check" {
  type = list(string)
}

variable "vcn_cidr_block" {
  type        = string
  description = "Hub VCN CIDR Block."
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Hub Public Subnet CIDR Block."
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "Hub Private Subnet CIDR Block."
}

variable "private_spoke_subnet_web_cidr_block" {
  type        = string
  description = "Spoke Web Subnet CIDR Block."
}
variable "private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Spoke App Subnet CIDR Block."
}
variable "private_spoke_subnet_db_cidr_block" {
  type        = string
  description = "Spoke DB Subnet CIDR Block."
}
variable "spoke_vcn_cidr" {
  type        = string
  description = "Spoke VCN CIDR Block."
}

# -----------------------------------------------------------------------------
# Monitoring Variables
# -----------------------------------------------------------------------------
variable "network_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Network Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.network_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.network_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "secops_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Secops Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.secops_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.secops_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "platform_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Platform notifications."
  validation {
    condition = length(
      [for e in var.platform_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.platform_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "identity_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Identity notifications."
  validation {
    condition = length(
      [for e in var.identity_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.identity_topic_endpoints)
    error_message = "Validation failed: invalid email address."
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
variable "is_create_alarms" {
  type        = bool
  description = "Enable Alarms Creation in all Compartment"
}
variable "enable_security_monitoring_alarms" {
  type        = bool
  description = "Enable Security Monitoring Alarms in Security Compartment"
}
variable "enable_network_monitoring_alarms" {
  type        = bool
  description = "Enable Network Monitoring Alarms in Network Compartment"
}
variable "enable_workload_monitoring_alarms" {
  type        = bool
  description = "Enable Workload Monitoring Alarms in Workload Compartment"
}

# -----------------------------------------------------------------------------
# Workload Variables
# -----------------------------------------------------------------------------

variable "workload_name_prefix" {
  type        = string
  description = "Workload Compartment Name Prefix"
}

# -----------------------------------------------------------------------------
# Workload Network Variables
# -----------------------------------------------------------------------------
variable "additional_workload_subnets_cidr_blocks" {
  type        = list(string)
  description = "A list of subnets cidr blocks in additional workload stack"
}
variable "enable_datasafe" {
  type    = bool
}