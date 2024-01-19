##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_kms_key" "key" {
  compartment_id = var.compartment_ocid
  display_name   = var.display_name

  key_shape {
    algorithm = var.shape_algorithm
    length    = var.shape_length
  }
  management_endpoint = var.management_endpoint
  protection_mode     = var.protection_mode
}
