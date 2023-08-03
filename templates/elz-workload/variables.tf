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

# -----------------------------------------------------------------------------
# Compartment Variables
# -----------------------------------------------------------------------------
variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

variable "environment_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "security_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
  default     = ""
}

variable "network_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
  default     = ""
}

variable "workload_name" {
  type        = string
  description = "Workload Compartment Name Prefix."
}

variable "workload_compartment_name" {
  type        = string
  description = "The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>."
  default     = ""
}

# -----------------------------------------------------------------------------
# Monitoring Variables
# -----------------------------------------------------------------------------
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
variable "is_create_alarms" {
  type        = bool
  description = "Enable Alarms Creation in all Compartment"
  default     = true
}
# -----------------------------------------------------------------------------
# Workload Expansion Variables
# -----------------------------------------------------------------------------
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
  type        = list(string)
  default     = [""]
}

variable "enable_security_monitoring_alarms" {
  type        = bool
  description = "Enable Security Monitoring Alarms in Security Compartment"
  default     = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_security_monitoring_alarms))
    error_message = "The workload_expansion_flag variable must be either true or false."
  }
}

variable "enable_network_monitoring_alarms" {
  type        = bool
  description = "Enable Network Monitoring Alarms in Network Compartment"
  default     = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_network_monitoring_alarms))
    error_message = "The workload_expansion_flag variable must be either true or false."
  }
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

# -----------------------------------------------------------------------------
# Identity Variables
# -----------------------------------------------------------------------------
variable "security_compartment_name" {
  type        = string
  description = "Security Compartment Name."
  default     = ""
}

variable "identity_domain_id" {
  type        = string
  description = "the ocid of identity domain"
  default     = "ocid1.domain."
  validation {
    condition     = can(regex("^domain$", split(".", var.identity_domain_id)[1]))
    error_message = "Only Domain are OCID is allowed."
  }
}

variable "idcs_endpoint" {
  type        = string
  description = "Identity Domain End Points"
  default     = "https://idcs-."
  validation {
    condition     = can(regex("^443$", split(":", var.idcs_endpoint)[2]))
    error_message = "Not Valid IDCS Endpoint."
  }
  validation {
    condition     =  can(regex("^https://idcs$", split("-", var.idcs_endpoint)[0]))
    error_message = "Not Valid IDCS Endpoint."
  }
}

variable "identity_domain_name" {
  type        = string
  description = "identity domain name"
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

variable "database_admin_group_name" {
  type        = string
  description = "the name of workload database admin group"
  default     = ""
}

variable "network_admin_group_name" {
  type        = string
  description = "the name of landing zone Network admin group"
  default     = ""
}