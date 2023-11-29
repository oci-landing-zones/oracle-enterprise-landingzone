##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "rpc_id" {
  value = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? oci_core_remote_peering_connection.remote_peering_connection[0].id : null
}