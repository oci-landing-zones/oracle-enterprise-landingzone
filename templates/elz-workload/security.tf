locals { 
  osms_dynamic_group_workload = {
    dynamic_group_name        = "OCI-${var.environment_prefix}-ELZ-${var.workload_name}-DG"
    dynamic_group_description = "OCI ELZ Workload Dynamic Group"

    general_matching_rule = <<EOT
    Any {
      instance.compartment.id = '${module.workload_compartment.compartment_id}'
    }
    EOT
  }

  osms_dg_policy_workload = {
    name        = "OCI-${var.environment_prefix}-ELZ-${var.workload_name}-OSMS-DG-Policy"
    description = "Workload OCI Landing Zone OS Management Service Dynamic Group Policy"

    statements = [
      "Allow dynamic-group ${module.workload_osms_dynamic_group.name} to read instance-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow dynamic-group ${module.workload_osms_dynamic_group.name} to use osms-managed-instances in compartment ${module.workload_compartment.compartment_name}"
    ]
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