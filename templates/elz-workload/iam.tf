# -----------------------------------------------------------------------------
# Compartment Resources 
# -----------------------------------------------------------------------------
locals {
  workload_compartment = {
    name        = var.workload_compartment_name != "" ? var.workload_compartment_name : "OCI-ELZ-${var.environment_prefix}-${var.workload_name}-${local.region_key[0]}"
    description = "Workload Compartment"
  }
}

module "workload_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = var.environment_compartment_id
  compartment_name          = local.workload_compartment.name
  compartment_description   = local.workload_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}
