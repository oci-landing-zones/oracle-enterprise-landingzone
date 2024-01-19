##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

data "oci_log_analytics_namespaces" "logging_analytics_namespaces" {
  compartment_id = var.tenancy_ocid
}