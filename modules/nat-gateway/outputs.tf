##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "nat_gw_id" {
  value = oci_core_nat_gateway.OCI-ELZ-NGW-P-HUB.id
  description = "NAT Gateway OCID."
}
