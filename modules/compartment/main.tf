##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_identity_compartment" "compartment" {
  compartment_id = var.compartment_parent_id
  description    = var.compartment_description
  name           = var.compartment_name
  enable_delete  = var.enable_compartment_delete
}

resource "time_sleep" "compartment_replication_delay" {
  depends_on      = [oci_identity_compartment.compartment]
  create_duration = "90s"
}
