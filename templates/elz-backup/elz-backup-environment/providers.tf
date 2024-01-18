##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################
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
