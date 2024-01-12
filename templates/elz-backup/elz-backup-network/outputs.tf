##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "spoke_web_subnet_ocid" {
  value = module.spoke.spoke_web_subnet_ocid
  description = "Spoke Web Subnet OCID."
}
output "subnets" {
  value = merge(module.hub_backup.subnets, module.spoke.subnets)
  description = "Hub & Spoke Subnet."
}
output "drg_id" {
  value = module.hub_backup.drg_id
  description = "DRG OCID."
}

output "service_gateway_value" {
      value = module.hub_backup.service_gateway_value
}