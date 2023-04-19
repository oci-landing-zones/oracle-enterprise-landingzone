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
# Domain Variables
# -----------------------------------------------------------------------------
variable "domain_admin_email" {
  type        = string
  description = "The email address for the identity domain admin."
}

# -----------------------------------------------------------------------------
# Policy Variables
# -----------------------------------------------------------------------------
variable "environment_compartment_name" {
  type = string
}

variable "environment_compartment_id" {
  type = string
}

variable "shared_compartment_name" {
  type = string
}

variable "shared_compartment_id" {
  type = string
}

variable "network_compartment_id" {
  type = string
}

variable "network_compartment_name" {
  type = string
}

variable "security_compartment_id" {
  type = string
}

variable "security_compartment_name" {
  type = string
}
variable "workload_compartment_id" {
  type = string

}
variable "workload_compartment_names" {
  type        = list(string)
  default     = []
  description = "The names of the workload compartments to update policies for the Admin Groups"
}

# -----------------------------------------------------------------------------
# Group Variables
# -----------------------------------------------------------------------------
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

variable "workload_compartment_name" {
  type        = string
  description = "The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>."
  default     = ""
}
variable "domain_license_type" {
  type        = string
  description = "Identity Domain License Type"
}
