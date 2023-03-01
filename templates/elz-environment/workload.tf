# -----------------------------------------------------------------------------
# Workload Resources 
# -----------------------------------------------------------------------------
locals {
  workload = {
    workload_name             = "Workload1"
    enable_compartment_delete = true
  }
}

module "workload" {
  source = "../elz-workload"

  tenancy_ocid               = var.tenancy_ocid
  region                     = var.region
  workload_name              = local.workload.workload_name
  enable_compartment_delete  = local.workload.enable_compartment_delete
  
  environment_prefix         = var.environment_prefix
  environment_compartment_id = module.compartment.compartments.environment.id
  security_compartment_id    = module.compartment.compartments.security.id
  network_compartment_id     = module.compartment.compartments.network.id
  workload_compartment_id    = module.workload.compartment_id

  enable_security_monitoring_alarms = var.enable_security_monitoring_alarms
  enable_network_monitoring_alarms  = var.enable_network_monitoring_alarms
  enable_workload_monitoring_alarms = var.enable_workload_monitoring_alarms

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
