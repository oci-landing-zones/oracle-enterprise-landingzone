##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "compartment_id" {
  value       = module.workload_compartment.compartment_id
  description = "Workload Compartment OCID."
}
output "compartment_name" {
  value = module.workload_compartment.compartment_name
  description = "Workload Compartment Name."
}

output "subnet_cidr_blocks" {
  value = [var.workload_private_spoke_subnet_app_cidr_block, 
           var.workload_private_spoke_subnet_db_cidr_block,
           var.workload_private_spoke_subnet_web_cidr_block,
  ]
  description = "Workload Subnet OCID Information."
}