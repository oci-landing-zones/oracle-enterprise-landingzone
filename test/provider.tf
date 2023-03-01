terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      version               = "4.96.0" # October 05, 2022 Release
      configuration_aliases = [oci, oci.home_region]
    }
  }
}

# -----------------------------------------------------------------------------
# Support for multi-region deployments
# -----------------------------------------------------------------------------
data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}

locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  home_region          = [for region in local.region_subscriptions : region.region_name if region.is_home_region == true]
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.region]
}

# -----------------------------------------------------------------------------
# Provider blocks for home region and alternate region(s)
# -----------------------------------------------------------------------------
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.current_user_ocid
  fingerprint      = var.api_fingerprint
  private_key      = var.api_private_key # if both set this takes precidence
  private_key_path = var.api_private_key_path
  region           = var.region
}

provider "oci" {
  alias            = "home_region"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.current_user_ocid
  fingerprint      = var.api_fingerprint
  private_key      = var.api_private_key # if both set this takes precidence
  private_key_path = var.api_private_key_path
  region           = local.home_region[0]
}

variable "region" {
  type        = string
  description = "the OCI region"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "current_user_ocid" {
  type        = string
  description = "OCID of the current user"
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

variable "api_private_key" {
  type        = string
  description = "The API private key"
  default     = ""
}