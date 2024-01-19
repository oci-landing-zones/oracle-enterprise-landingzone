##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "bastion_ocid" {
  value       = oci_bastion_bastion.bastion.id
  description = "The OCID of the bastion created  "
}