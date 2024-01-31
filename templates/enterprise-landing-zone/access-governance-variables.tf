#########################################################
#                                                       #
#         DO NOT MODIFY ANYTHING IN THIS FILE           #
#                                                       #
#########################################################

variable "prod_enable_access_governance" {
  type    = bool
  default = true
}

variable "nonprod_enable_access_governance" {
  type    = bool
  default = true
}

#variable "private_key_path" {
#  type        = string
#  default     = ""
#  description = "Private Key Path of Administrator."
#}
#
#variable "user_ocid" {
#  type        = string
#  default     = ""
#  description = "OCID of the Administrator."
#}
#
#variable "fingerprint" {
#  type        = string
#  default     = ""
#  description = "Fingerprint of the Administrator."
#}

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

####################################### Required Variables ######################################

variable "admin_domain_name" {
  default     = "Default"
  description = "Administrator's Identity Domain Name."
}
################################## Prod Details ###########################################
variable "prod_ag_license_type" {
  description = "Access Governance Instance License Type."
  validation {
    condition     = can(regex("^(Access Governance Premium|Access Governance for Oracle Workloads|Access Governance for Oracle Cloud Infrastructure)$", var.prod_ag_license_type))
    error_message = "Please select any value among Access Governance Premium, Access Governance for Oracle Workloads, Access Governance for Oracle Cloud Infrastructure."
  }
}

variable "prod_service_instance_display_name" {
  description = "Access Governance Instance Display Name."
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.prod_service_instance_display_name))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}

variable "prod_service_instance_description" {
  description = "Access Governance Instance Description."
}

#variable "prod_service_instance_compartment_ocid" {
#  description = "Compartment OCID for Access Governance Instance."
#}

variable "prod_use_existing_agcs_user" {
  type        = bool
  default     = false
  description = "Set this value to either use existing Access Governance user or create new one."
}

variable "prod_agcs_user_private_key_path" {
  sensitive   = true
  type        = string
  default     = ""
  description = "Private Key Path for Access Governance User."
}

variable "prod_agcs_user_private_key" {
  sensitive   = true
  type        = string
  default     = ""
  description = "Private Key for Access Governance User"
}

variable "prod_agcs_user_ocid_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's OCID."
}

variable "prod_agcs_user_tenancy_ocid_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's Tenancy OCID."
}

variable "prod_agcs_user_fingerprint_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's Fingerprint."
}

variable "prod_agcs_user_region_oci_system" {
  type        = string
  default     = ""
  description = "Region of the Access Governance User."
}

variable "prod_oci_system_name" {
  type        = string
  default     = ""
  description = "OCI Connected System Name."
}

variable "prod_oci_system_description" {
  type        = string
  default     = ""
  description = "OCI Connected System Description."
}

####################### New Prod AG User ###############################
variable "prod_agcs_user_domain_name" {
  default     = "Default"
  description = "Domain where Access Governance User will be created."
}

variable "prod_agcs_user_group_display_name" {
  description = "Group to create for Access Governance User."
  default     = "agcs_group"
}

variable "prod_agcs_user_name" {
  default     = "agcs_user"
  description = "New Access Governance User's name."
}

variable "prod_agcs_user_email" {
  default     = "something_prod@example.com"
  description = "Email address for the user."
  validation {
    condition     = can(regex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$", var.prod_agcs_user_email))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}
################################## Non Prod Details###########################################
variable "nonprod_ag_license_type" {
  description = "Access Governance Instance License Type."
  validation {
    condition     = can(regex("^(Access Governance Premium|Access Governance for Oracle Workloads|Access Governance for Oracle Cloud Infrastructure)$", var.nonprod_ag_license_type))
    error_message = "Please select any value among Access Governance Premium, Access Governance for Oracle Workloads, Access Governance for Oracle Cloud Infrastructure."
  }
}

variable "nonprod_service_instance_display_name" {
  description = "Access Governance Instance Display Name."
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.nonprod_service_instance_display_name))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}

variable "nonprod_service_instance_description" {
  description = "Access Governance Instance Description."
}

#variable "nonprod_service_instance_compartment_ocid" {
#  description = "Compartment OCID for Access Governance Instance."
#}

variable "nonprod_use_existing_agcs_user" {
  type        = bool
  default     = false
  description = "Set this value to either use existing Access Governance user or create new one."
}

variable "nonprod_agcs_user_private_key_path" {
  sensitive   = true
  type        = string
  default     = ""
  description = "Private Key Path for Access Governance User."
}

variable "nonprod_agcs_user_private_key" {
  sensitive   = true
  type        = string
  default     = ""
  description = "Private Key for Access Governance User"
}

variable "nonprod_agcs_user_ocid_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's OCID."
}

variable "nonprod_agcs_user_tenancy_ocid_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's Tenancy OCID."
}

variable "nonprod_agcs_user_fingerprint_oci_system" {
  type        = string
  default     = ""
  description = "Access Governance User's Fingerprint."
}

variable "nonprod_agcs_user_region_oci_system" {
  type        = string
  default     = ""
  description = "Region of the Access Governance User."
}

variable "nonprod_oci_system_name" {
  type        = string
  default     = ""
  description = "OCI Connected System Name."
}

variable "nonprod_oci_system_description" {
  type        = string
  default     = ""
  description = "OCI Connected System Description."
}

####################### New Nonprod AG User ###############################
variable "nonprod_agcs_user_domain_name" {
  default     = "Default"
  description = "Domain where Access Governance User will be created."
}

variable "nonprod_agcs_user_group_display_name" {
  description = "Group to create for Access Governance User."
  default     = "agcs_group"
}

variable "nonprod_agcs_user_name" {
  default     = "agcs_user"
  description = "New Access Governance User's name."
}

variable "nonprod_agcs_user_email" {
  default     = "something_nonprod@example.com"
  description = "Email address for the user."
  validation {
    condition     = can(regex("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$", var.nonprod_agcs_user_email))
    error_message = "Must be unique, start with a letter and contain only alphanumeric characters without any space. Hyphen (-) and underscore ( _ ) are allowed only."
  }
}