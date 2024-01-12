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

resource "oci_logging_log" "service_log" {
  display_name = var.log_display_name
  log_group_id = var.log_group_id
  log_type = var.log_type

  configuration {
    source {
      category = var.log_source_category
      resource = var.log_source_resource
      service = var.log_source_service
      source_type = var.log_source_type
    }
  }
}
