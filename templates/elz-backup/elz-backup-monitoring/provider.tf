terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      version               = "5.9.0"
      configuration_aliases = [oci, oci.backup_region]
    }
  }
}