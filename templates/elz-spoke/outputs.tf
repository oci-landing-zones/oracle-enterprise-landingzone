##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "spoke_web_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_web_display_name]
  description = "Spoke Web Subnet OCID."
}

output "spoke_app_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
  description = "Spoke App Subnet OCID."
}

output "spoke_db_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_db_display_name]
  description = "Spoke DB Subnet OCID."
}

output "subnets" {
  value = {
    (var.workload_private_spoke_subnet_db_display_name)  = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_db_display_name]
    (var.workload_private_spoke_subnet_app_display_name) = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
    (var.workload_private_spoke_subnet_web_display_name) = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_web_display_name]
  }
  description = "The Spoke Subnet OCID"
}