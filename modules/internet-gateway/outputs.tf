##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "internet_gw_id" {
  value = oci_core_internet_gateway.OCI-ELZ-IGW-P-HUB.id
  description = "Internet Gateway Display Name."
}
