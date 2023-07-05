# -----------------------------------------------------------------------------
# Provider Requirements if using stack as a module
# -----------------------------------------------------------------------------
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      version               = "5.1.0"
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# # -----------------------------------------------------------------------------
# # WARNING!
# # UNCOMMENT EVERYTHING BELOW AND COMMENT EVERYTHING ABOVE IF YOU WISH TO USE THIS 
# # STACK AS A STANDALONE - DO NOT TOUCH IF USING THIS STACK IN A MODULE CALL
# # Provider Requirements if using stack as standalone
# # -----------------------------------------------------------------------------
# terraform {
#   required_version = ">= 1.0.0"

#   required_providers {
#     oci = {
#       source  = "oracle/oci"
#       version = "5.1.0"
#     }
#   }
# }

# # -----------------------------------------------------------------------------
# # Provider blocks for home region and alternate region(s)
# # -----------------------------------------------------------------------------
# provider "oci" {
#   tenancy_ocid     = var.tenancy_ocid
#   user_ocid        = var.current_user_ocid
#   fingerprint      = var.api_fingerprint
#   private_key_path = var.api_private_key_path
#   region           = var.region
# }

# provider "oci" {
#   alias            = "home_region"
#   tenancy_ocid     = var.tenancy_ocid
#   user_ocid        = var.current_user_ocid
#   fingerprint      = var.api_fingerprint
#   private_key_path = var.api_private_key_path
#   region           = local.home_region[0]
# }

# # -----------------------------------------------------------------------------
# # Provider Variables
# # -----------------------------------------------------------------------------
# variable "current_user_ocid" {
#   type        = string
#   description = "The OCID of the current user"
#   default     = ""
# }

# variable "api_fingerprint" {
#   type        = string
#   description = "The fingerprint of API"
#   default     = ""
# }

# variable "api_private_key_path" {
#   type        = string
#   description = "The local path to the API private key"
#   default     = ""
# }
