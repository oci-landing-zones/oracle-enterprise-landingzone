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

variable "resource_label" {
  type        = string
  default     = ""
  description = "A prefix used to avoid naming conflicts if multiple Landing Zones are deployed."
}

# -----------------------------------------------------------------------------
# Compartment Variables
# -----------------------------------------------------------------------------
variable "home_compartment_name" {
  type        = string
  default     = "LIVELAB-OCI-CMP-HOME"
  description = "The name of the Landing Zone home compartment."
}

variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

# -----------------------------------------------------------------------------
# Identity Variables
# -----------------------------------------------------------------------------
variable "break_glass_user_email_list" {
  type        = list(string)
  description = "Unique list of break glass user email addresses that do not exist in the tenancy. These users are added to the Administrator group."
  default     = []
  validation {
    condition     = alltrue([for i in var.break_glass_user_email_list : can(regex("^[^\\s@]+@([^\\s@\\.,]+.)+[^\\s@\\.,]{2,}$", i))])
    error_message = "Must be a list of valid email addresses."
  }
}

variable "onboard_log_analytics" {
  type        = bool
  description = "Set to true to onboard the tenancy to logging analytics. "
  default     = true
}

variable "domain_license_type" {
  type        =  string
  description = "Identity Domain License Type."
  default     = "premium"
}

# -----------------------------------------------------------------------------
# Prod Enviroment Variables
# -----------------------------------------------------------------------------
variable "prod_domain_admin_email" {
  type        = string
  description = "The email address for the prod identity domain admin."
}

#@TODO revisit this naming scheme of adding prod/nonprod in front of var names
variable "prod_network_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Network Administrators Group. Defaults to OCI-ELZ-UGP-P-NET-ADMIN if blank or not provided."
}

variable "prod_security_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Security Administrators Group. Defaults to OCI-ELZ-UGP-P-SEC-ADMIN if blank or not provided."
}

variable "prod_iam_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone IAM Administrators Group. Defaults to OCI-ELZ-UGP-P-IDP-ADMIN if blank or not provided."
}

variable "prod_platform_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Platform Administrators Group. Defaults to OCI-ELZ-UGP-P-PLT-ADMIN if blank or not provided."
}

variable "prod_ops_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Ops Administrators Group. Defaults to OCI-ELZ-UGP-P-OPS-ADMIN if blank or not provided."
}

variable "prod_workload_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Workload Administrators Group. Defaults to OCI-ELZ-UGP-P-WRK-ADMIN if blank or not provided."
}
variable "prod_application_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Application Administrators Group. Defaults to OCI-ELZ-UGP-P-APP-ADMIN if blank or not provided."
}
variable "prod_database_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Database Logging Administrators Group. Defaults to OCI-ELZ-UGP-P-DB-ADMIN if blank or not provided."
}

variable "prod_enable_budget" {
  type        = bool
  default     = false
  description = "Production Enable Budget."
}

variable "prod_budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card. Required *if* prod_enable_budget is true."
  type        = string
  default     = ""
}

variable "prod_budget_alert_rule_threshold" {
  description = "The threshold for the budget alert. Required *if* prod_enable_budget is true."
  type        = string
  default     = ""
}

variable "prod_budget_alert_rule_message" {
  description = "The alert message for budget alerts. Required *if* prod_enable_budget is true."
  type        = string
  default     = ""
}

variable "prod_budget_alert_rule_recipients" {
  description = "The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon. Required *if* prod_enable_budget is true."
  type        = string
  default     = ""
}
# -----------------------------------------------------------------------------
# NonProd Enviroment Variables
# -----------------------------------------------------------------------------
variable "nonprod_domain_admin_email" {
  type        = string
  description = "The email address for the non prod identity domain admin."
  default     = ""
}

variable "nonprod_network_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Network Administrators Group. Defaults to OCI-ELZ-UGP-N-NET-ADMIN if blank or not provided."
}

variable "nonprod_security_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Security Administrators Group. Defaults to OCI-ELZ-UGP-N-SEC-ADMIN if blank or not provided."
}

variable "nonprod_iam_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone IAM Administrators Group. Defaults to OCI-ELZ-UGP-N-IDP-ADMIN if blank or not provided."
}

variable "nonprod_platform_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Platform Administrators Group. Defaults to OCI-ELZ-UGP-N-PLT-ADMIN if blank or not provided."
}

variable "nonprod_ops_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Landing Zone Ops Administrators Group. Defaults to OCI-ELZ-UGP-N-OPS-ADMIN if blank or not provided."
}

variable "nonprod_workload_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Workload Administrators Group. Defaults to OCI-ELZ-UGP-N-WRK-ADMIN if blank or not provided."
}
variable "nonprod_application_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Application Administrators Group. Defaults to OCI-ELZ-UGP-N-APP-ADMIN if blank or not provided."
}
variable "nonprod_database_admin_group_name" {
  type        = string
  default     = ""
  description = "The group name for the OCI Database Logging Administrators Group. Defaults to OCI-ELZ-UGP-N-DB-ADMIN if blank or not provided."
}

variable "nonprod_enable_budget" {
  type        = bool
  default     = false
  description = "Non-Production Enable Budget."
}


variable "nonprod_budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card. Required *if* nonprod_enable_budget is true."
  type        = string
  default     = ""
}

variable "nonprod_budget_alert_rule_threshold" {
  description = "The threshold for the budget alert. Required *if* nonprod_enable_budget is true."
  type        = string
  default     = ""
}

variable "nonprod_budget_alert_rule_message" {
  description = "The alert message for budget alerts. Required *if* nonprod_enable_budget is true."
  type        = string
  default     = ""
}

variable "nonprod_budget_alert_rule_recipients" {
  description = "The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon. Required *if* nonprod_enable_budget is true."
  type        = string
  default     = ""
}
# -----------------------------------------------------------------------------
# Security Variables
# -----------------------------------------------------------------------------
variable "enable_cloud_guard" {
  type        = bool
  default     = false
  description = "true if you don't have cloud guard enabled, false if you've already have cloud guard enabled."
}

variable "cloud_guard_target_tenancy" {
  type        = bool
  default     = false
  description = "true if cloud guard targets to tenancy, false if cloud guard targets to Landing Zone home compartment"
}

variable "prod_bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}

variable "prod_enable_bastion" {
  type        = bool
  description = "Option to enable bastion service"
}

variable "prod_vault_type" {
  type        = string
  description = "The type of vault to create. "
  default     = "DEFAULT"
}

variable "prod_vault_replica_region" {
  type        = string
  description = "the region to be created replica to. Required *if* prod_enable_vault_replication is true."
  default     = ""
}

variable "prod_enable_vault_replication" {
  type        = bool
  description = "Option to enable vault replication"
  default     = false
}

variable "prod_create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key"
  default     = true
}

# -----------------------------------------------------------------------------
# Network Variables
# -----------------------------------------------------------------------------
variable "prod_enable_internet_gateway_hub" {
  type        = string
  description = "Option to enable TRUE and Disable false."
  default     = "false"
}


variable "prod_enable_nat_gateway_hub" {
  type        = string
  description = "Option to enable TRUE and Disable false."
  default     = "false"
}

variable "prod_enable_service_gateway_hub" {
  type        = string
  description = "Option to enable TRUE and Disable false."
  default     = "false"
}

variable "prod_enable_nat_gateway_spoke" {
  type        = string
  description = "Option to enable TRUE and Disable false."
  default     = "false"
}

variable "prod_enable_service_gateway_spoke" {
  type        = string
  description = "Option to enable TRUE and Disable false."
  default     = "false"
}
variable "igw_hub_check" {
  type    = list(string)
  default = [""]
}

variable "nat_gw_hub_check" {
  type    = list(string)
  default = [""]
}

variable "service_gw_hub_check" {
  type    = list(string)
  default = [""]
}

variable "nat_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "service_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "prod_hub_vcn_cidr_block" {
  type        = string
  description = "Production Enivornment HUB VCN CIDR Block."
}

variable "prod_hub_public_subnet_cidr_block" {
  type        = string
  description = "Production Enivornment HUB Public Subnet CIDR Block."
}

variable "prod_hub_private_subnet_cidr_block" {
  type        = string
  description = "Production Enivornment HUB Private Subnet CIDR Block."
}

variable "prod_spoke_subnet_web_cidr_block" {
  type        = string
  description = "Production Enivornment Spoke Web Subnet CIDR Block."
}
variable "prod_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Production Enivornment Spoke App Subnet CIDR Block."
}
variable "prod_spoke_subnet_db_cidr_block" {
  type        = string
  description = "Production Enivornment Spoke DB Subnet CIDR Block."
}

variable "prod_spoke_vcn_cidr" {
  type        = string
  description = "Production Enivornment Spoke VCN CIDR Block."
}

#Tagging 
variable "prod_enable_tagging" {
  type        = bool
  default     = false
  description = "Option to enable Tagging gateway in Production environment"
}

variable "prod_cost_center_tagging" {
  type        = string
  description = "Production Cost Center."
}

variable "prod_geo_location_tagging" {
  type        = string
  description = "Production Geo Center."
}

# -----------------------------------------------------------------------------
# Monitoring Variables
# -----------------------------------------------------------------------------
variable "prod_network_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Network Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.prod_network_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_network_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_secops_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Secops Warning and Critical notifications."
  validation {
    condition = length(
      [for e in var.prod_secops_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_secops_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_platform_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Platform notifications."
  validation {
    condition = length(
      [for e in var.prod_platform_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_platform_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "prod_identity_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Identity notifications."
  validation {
    condition = length(
      [for e in var.prod_identity_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_identity_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}
variable "prod_workload_topic_endpoints" {
  type        = list(string)
  default     = []
  description = "List of email addresses for Prod Workload notifications."
  validation {
    condition = length(
      [for e in var.prod_workload_topic_endpoints :
      e if length(regexall("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", e)) > 0]
    ) == length(var.prod_workload_topic_endpoints)
    error_message = "Validation failed: invalid email address."
  }
}

variable "is_create_alarms" {
  type        = bool
  default     = false
  description = "Enable Alarms Creation in all Compartment"
}
variable "is_service_connector_limit" {
  type        = bool
  default     = true
  description = "Restrict Number of Service Connector Deployment in Tenancy if limit is two"
}
variable "prod_enable_security_monitoring_alarms" {
  type        = bool
  default     = false
  description = "Enable Security Monitoring Alarms in Production Security Compartment"
}
variable "prod_enable_network_monitoring_alarms" {
  type        = bool
  default     = false
  description = "Enable Network Monitoring Alarms in Production Network Compartment"
}
variable "prod_enable_workload_monitoring_alarms" {
  type        = bool
  default     = false
  description = "Enable Workload Monitoring Alarms in Production Workload Compartment"
}
# -----------------------------------------------------------------------------
# Workload Network Variables
# -----------------------------------------------------------------------------
variable "prod_additional_workload_subnets_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "A list of subnets cidr blocks in additional workload stack in prod"
}