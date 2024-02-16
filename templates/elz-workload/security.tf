##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

locals {
  osms_dynamic_group_workload = {
    dynamic_group_name        = "${var.resource_label}-OCI-${var.environment_prefix}-ELZ-${var.workload_name}-DG1"
    dynamic_group_description = "OCI ELZ Workload Dynamic Group"

    general_matching_rule = <<EOT
    Any {
      instance.compartment.id = '${module.workload_compartment.compartment_id}'
    }
    EOT
  }

  osms_dg_policy_workload = {
    name        = "${var.resource_label}-OCI-${var.environment_prefix}-ELZ-${var.workload_name}-OSMS-DG-Policy"
    description = "Workload OCI Landing Zone OS Management Service Dynamic Group Policy"

    statements = [
      "Allow dynamic-group ${module.workload_osms_dynamic_group.name} to read instance-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow dynamic-group ${module.workload_osms_dynamic_group.name} to use osms-managed-instances in compartment ${module.workload_compartment.compartment_name}"
    ]
  }

  bastion = {
    name = "${var.resource_label}-OCI-ELZ-BAS-${var.environment_prefix}"
    bastion_target_subnet_id = var.workload_expansion_flag ? module.workload_expansion_spoke[0].spoke_web_subnet_ocid : var.bastion_target_subnet_id
  }

}
module "workload_osms_dynamic_group" {
  source        = "../../modules/dynamic-group"
  tenancy_ocid  = var.tenancy_ocid
  description   = local.osms_dynamic_group_workload.dynamic_group_description
  name          = local.osms_dynamic_group_workload.dynamic_group_name
  matching_rule = local.osms_dynamic_group_workload.general_matching_rule
}

module "workload_osms_dg_policy" {
  source = "../../modules/policies"

  compartment_ocid = module.workload_compartment.compartment_id
  policy_name      = local.osms_dg_policy_workload.name
  description      = local.osms_dg_policy_workload.description
  statements       = local.osms_dg_policy_workload.statements
}

module "bastion" {
  source                               = "../../modules/bastion"
  count                                = var.enable_bastion ? 1 : 0
  target_subnet_id                     = local.bastion.bastion_target_subnet_id
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  bastion_name                         = local.bastion.name
  compartment_id                       = var.security_compartment_id
}