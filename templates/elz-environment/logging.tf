module "logging" {
  source                              = "../elz-logging"
  region                              = var.region
  environment_prefix                  = var.environment_prefix
  tenancy_ocid                        = var.tenancy_ocid
  home_compartment_id                 = var.home_compartment_id
  home_compartment_name               = var.home_compartment_name
  is_service_connector_limit          = var.is_service_connector_limit
  security_compartment_id             = module.compartment.compartments.security.id
  master_encryption_key               = module.security.key_id
  logging_compartment_id              = module.compartment.compartments.logging.id
  resource_label                      = var.resource_label
  retention_policy_duration_amount    = var.retention_policy_duration_amount
  retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
  subnets_map                         = module.network.subnets

  depends_on = [ module.network ]

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}