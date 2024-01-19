##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "vcn" {
  value = module.hub.vcn_id
  description = "Hub VCN OCID ID."
}

output "drg_id" {
  value = module.hub.drg_id
  description = "DRG OCID ID."
}

output "subnets" {
  value = merge(module.hub.subnets, module.spoke.subnets)
  description = "Hub & Spoke Subnet."
}

output "spoke_web_subnet_ocid" {
  value = module.spoke.spoke_web_subnet_ocid
  description = "Spoke Web Subnet OCID."
}

output "spoke_app_subnet_ocid" {
  value = module.spoke.spoke_app_subnet_ocid
  description = "Spoke App Subnet OCID."
}

output "spoke_db_subnet_ocid" {
  value = module.spoke.spoke_db_subnet_ocid
  description = "Spoke DB Subnet OCID."
}


