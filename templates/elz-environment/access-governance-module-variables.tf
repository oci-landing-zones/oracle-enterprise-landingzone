#########################################################
#                                                       #
#         DO NOT MODIFY ANYTHING IN THIS FILE           #
#                                                       #
#########################################################

variable "enable_access_governance" {
  type    = bool
  default = true
}

variable "ag_api_private_key_path" {
  type        = string
  default     = ""
  description = "Private Key Path of Administrator."
}

variable "ag_current_user_ocid" {
  type        = string
  default     = ""
  description = "OCID of the Administrator."
}

variable "ag_api_fingerprint" {
  type        = string
  default     = ""
  description = "Fingerprint of the Administrator."
}

variable "ag_region" {
  type        = string
  default     = ""
  description = "Fingerprint of the Administrator."
}

variable "ag_tenancy_ocid" {
  type        = string
  default     = ""
  description = "Fingerprint of the Administrator."
}

variable "namespace_service_endpoint" {
  type        = string
  default     = ""
  description = "If Access Governance instance needs to be created in a namespace."
}

variable "should_create_connected_system" {
  type        = bool
  default     = true
  description = "If Namespace endpoint is given, select this option to add or skip OCI connected system."
}

####################################### Required Variables ############################################################

variable "admin_domain_name" {
  default     = "Default"
  description = "Administrator's Identity Domain Name."
}

variable "admin_domain_compartment_ocid" {
  default     = ""
  description = "Administrator's Identity Domain's Compartment."
}

variable "ag_license_type" {
  description = "Access Governance Instance License Type."
  validation {
    condition     = can(regex("^(Access Governance Premium|Access Governance for Oracle Workloads|Access Governance for Oracle Cloud Infrastructure)$", var.ag_license_type))
    error_message = "Please select any value among Access Governance Premium, Access Governance for Oracle Workloads, Access Governance for Oracle Cloud Infrastructure."
  }
}

variable "service_instance_display_name" {
  description = "Access Governance Instance Display Name."
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.service_instance_display_name))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}

variable "service_instance_description" {
  description = "Access Governance Instance Description."
}

#variable "service_instance_compartment_ocid" {
#  description = "Compartment OCID for Access Governance Instance."
#}

variable "use_existing_agcs_user" {
  type        = bool
  default     = false
  description = "Set this value to either use existing Access Governance user or create new one."
}

variable "agcs_user_private_key_path" {
  sensitive   = true
  type        = string
  default     = ""
  description = "Private Key Path for Access Governance User."
}

variable "agcs_user_private_key" {
  sensitive   = true
  type        = string
  default     = ""
  description = "Private Key for Access Governance User"
}

variable "agcs_user_ocid_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's OCID."
}

variable "agcs_user_tenancy_ocid_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's Tenancy OCID."
}

variable "agcs_user_fingerprint_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's Fingerprint."
}

variable "agcs_user_region_oci_system" {
  type        = string
  default     = ""
  description = "Region of the Access Governance User."
}

variable "oci_system_name" {
  type        = string
  default     = ""
  description = "OCI Connected System Name."
}

variable "oci_system_description" {
  type        = string
  default     = ""
  description = "OCI Connected System Description."
}

####################### New AG User ###############################
variable "agcs_user_domain_name" {
  default     = "Default"
  description = "Domain where Access Governance User will be created."
}

variable "agcs_user_group_display_name" {
  description = "Group to create for Access Governance User."
  default     = "agcs_group"
}

variable "agcs_user_name" {
  default     = "agcs_user"
  description = "New Access Governance User's name."
}

variable "agcs_user_email" {
  default     = "something@example.com"
  description = "Email address for the user."
  validation {
    condition     = can(regex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$", var.agcs_user_email))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}