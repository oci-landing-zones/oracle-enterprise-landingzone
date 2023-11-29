##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "service_gw_id" {
  value = oci_core_service_gateway.service_gateway_all_svcs.id
  description = "Service Gateway OCID."
}
