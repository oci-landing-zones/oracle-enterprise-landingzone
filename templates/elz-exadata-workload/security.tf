locals {
  osms_dynamic_group = {
    dynamic_group_name        = "${var.resource_label}-OCI-ELZ-DG-${var.environment_prefix}-${var.workload_name}"
    dynamic_group_description = "OCI ELZ Dynamic Group - ${var.workload_name}"

    general_matching_rule = <<EOT
    Any {
      instance.compartment.id = '${module.workload_compartment.compartment_id}'
    }
    EOT
  }

  bastion = {
    name = "${var.resource_label}-OCI-ELZ-BAS-${var.environment_prefix}-${var.workload_name}"
  }

}

module "osms_dynamic_group" {
  source        = "../../modules/dynamic-group"
  tenancy_ocid  = var.tenancy_ocid
  description   = local.osms_dynamic_group.dynamic_group_description
  name          = local.osms_dynamic_group.dynamic_group_name
  matching_rule = local.osms_dynamic_group.general_matching_rule

  depends_on = [module.workload_compartment]
}

module "bastion" {
  source                               = "../../modules/bastion"
  count                                = var.enable_bastion ? 1 : 0
  target_subnet_id                     = module.exadata_workload_expansion_spoke.subnets["OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-LB"]
  bastion_client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  bastion_name                         = local.bastion.name
  compartment_id                       = var.security_compartment_id
}
