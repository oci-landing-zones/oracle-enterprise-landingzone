# -----------------------------------------------------------------------------
# Provider Requirements if using stack as a module
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      version               = "5.9.0"
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# # -----------------------------------------------------------------------------
# # WARNING!
# # UNCOMMENT BELOW SECTION AND COMMENT EVERYTHING ABOVE IF YOU WISH TO USE THIS
# # STACK AS A STANDALONE - DO NOT TOUCH IF USING THIS STACK IN A MODULE CALL
# # -----------------------------------------------------------------------------

#terraform {
#  required_version = ">= 1.0.0"
#
#  required_providers {
#    oci = {
#      source  = "oracle/oci"
#      version = "5.9.0"
#    }
#  }
#}
#
#provider "oci" {
#  tenancy_ocid     = var.ag_tenancy_ocid
#  user_ocid        = var.current_user_ocid
#  fingerprint      = var.api_fingerprint
#  private_key_path = var.api_private_key_path
#  region           = var.ag_region
#}
#
#provider "oci" {
#  alias            = "home_region"
#  tenancy_ocid     = var.ag_tenancy_ocid
#  user_ocid        = var.current_user_ocid
#  fingerprint      = var.api_fingerprint
#  private_key_path = var.api_private_key_path
#  region           = local.home_region[0]
#}

# # -----------------------------DO NOT MODIFY ANY THING BEYOND HERE------------------------
# # Provider / Python SDK Auth Variables
# # Do not remove/comment out these lines as it is required for python script authentication
# # ----------------------------------------------------------------------------------------
variable "current_user_ocid" {
  type        = string
  description = "The OCID of the current user"
  default     = ""
}

variable "api_fingerprint" {
  type        = string
  description = "The fingerprint of API"
  default     = ""
}

variable "api_private_key_path" {
  type        = string
  description = "The local path to the API private key"
  default     = ""
}
