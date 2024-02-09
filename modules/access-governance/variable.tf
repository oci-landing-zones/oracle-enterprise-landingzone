#########################################################
#                                                       #
#             DO NOT MODIFY ANYTHING HERE               #
#                                                       #
#########################################################

variable "api_private_key_path" {
  default     = ""
  description = "Private Key Path of Administrator."
}

  variable "current_user_ocid" {
  default     = ""
  description = "OCID of the Administrator."
}

variable "api_fingerprint" {
  default     = ""
  description = "Fingerprint of the Administrator."
}

variable "tenancy_ocid" {
  default     = ""
  description = "OCID of the Administrator's Tenancy."
}

variable "region" {
  description     = "Region of the Administrator"
  validation {
    condition     = length(trim(var.region, "")) > 0
    error_message = "Validation failed for region: value is required."
  }
}

#variable "admin_region_service_instance" {
#  default = ""
#  description = "Region of the Administrator"
#}

variable "admin_domain_name" {
  default     = "Default"
  description = "Administrator's Identity Domain Name."
}

variable "admin_domain_compartment_ocid" {
  default     = ""
  description = "Administrator's Identity Domain's Compartment."
}


variable "use_existing_agcs_user" {
  type        = bool
  default     = false
  description = "Set this value to either use existing Access Governance user or create new one."
}

variable "agcs_user_private_key_path" {
  sensitive   = true
  default     = ""
  description = "Private Key Path for Access Governance User."
}

variable "agcs_user_private_key" {
  sensitive   = true
  default     = ""
  description = "Private Key for Access Governance User"
}

variable "agcs_user_ocid_oci_system" {
  default     = ""
  description = "Access Governance User's OCID."
}

variable "agcs_user_tenancy_ocid_oci_system" {
  default     = ""
  description = "Access Governance User's Tenancy OCID."
}

variable "agcs_user_fingerprint_oci_system" {
  default     = ""
  description = "Access Governance User's Fingerprint."
}

variable "namespace_service_endpoint" {
  default     = ""
  description = "If Access Governance instance needs to be created in a namespace."
}

variable "should_create_connected_system" {
  type        = bool
  default     = true
  description = "If Namespace endpoint is given, select this option to add or skip OCI connected system."
}

variable "agcs_user_region_oci_system" {
  default     = ""
  description = "Region of the Access Governance User."
}

variable "service_instance_display_name" {
  description     = "Access Governance Instance Display Name."
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.service_instance_display_name))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}

variable "service_instance_description" {
  description = "Access Governance Instance Description."
}

variable "ag_license_type" {
  description     = "Access Governance Instance License Type."
  validation {
    condition     = can(regex("^(Access Governance Premium|Access Governance for Oracle Workloads|Access Governance for Oracle Cloud Infrastructure)$", var.ag_license_type))
    error_message = "Please select any value among Access Governance Premium, Access Governance for Oracle Workloads, Access Governance for Oracle Cloud Infrastructure."
  }
}

variable "service_instance_compartment_ocid" {
  description = "Compartment OCID for Access Governance Instance."
}

variable "oci_system_name" {
  default     = ""
  description = "OCI Connected System Name."
}

variable "oci_system_description" {
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

variable "agcs_user_username" {
  default     = "agcs_user"
  description = "User name for the new Access Governance User."
}

variable "agcs_user_family_name" {
  default     = "Access Governance User"
  description = "Family name for the new AG User."
}

variable "agcs_user_name" {
  default     = "agcs_user"
  description = "New Access Governance User's name."
}

variable "agcs_user_given_name" {
  description = "Given name for the new AG User."
  default     = "AG"
}

variable "agcs_user_email" {
  default         = "something@example.com"
  description     = "Email address for the user."
  validation {
    condition     = can(regex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$", var.agcs_user_email))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}