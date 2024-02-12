##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "spoke_lb_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_lb_display_name]
}

output "spoke_app_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
}

output "spoke_client_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_client_display_name]
}

output "spoke_backup_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_backup_display_name]
}

output "spoke_vcn" {
  value = module.workload_spoke_vcn.vcn
}

output "subnets" {
  value = {
    (var.workload_private_spoke_subnet_lb_display_name)     = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_lb_display_name]
    (var.workload_private_spoke_subnet_app_display_name)    = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
    (var.workload_private_spoke_subnet_client_display_name) = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_client_display_name]
    (var.workload_private_spoke_subnet_backup_display_name) = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_backup_display_name]
  }
  description = "The spoke subnets OCIDs"
}
