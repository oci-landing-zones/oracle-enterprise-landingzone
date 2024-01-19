##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "subnets" {
  value       = module.prod_environment.subnets
  description = "The subnet OCID"
}

output "vcn" {
  value = module.prod_environment.vcn
}

output "dynamic_group_detail" {
  value = module.osms_dynamic_group
}

output "workload_compartment_id" {
  value = module.prod_environment.workload_compartment_id
}