##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "id" {
  value       = oci_identity_dynamic_group.dynamic_group.id
  description = "The OCID of dynamic group created"
}

output "name" {
  value       = oci_identity_dynamic_group.dynamic_group.name
  description = "The name of dynamic group created"
}