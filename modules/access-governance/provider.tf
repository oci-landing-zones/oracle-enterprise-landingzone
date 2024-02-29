terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}
# Enable/uncomment below lines to run access-governance module as root for terraform CLI
#provider "oci" {
#  private_key_path = var.api_private_key_path
#  user_ocid        = var.current_user_ocid
#  fingerprint      = var.api_fingerprint
#  region           = var.region
#  tenancy_ocid     = var.tenancy_ocid
#}