module "monitoring" {
  source             = "../elz-backup-monitoring"
  tenancy_ocid       = var.tenancy_ocid
  backup_region                     = var.backup_region
  environment_prefix = var.environment_prefix
  resource_label     = var.resource_label
  home_compartment_id  = var.home_compartment_id
  is_baseline_deploy           = var.is_baseline_deploy

  environment_compartment_id = var.environment_compartment_id
  security_compartment_id    = var.security_compartment_id
  network_compartment_id     = var.network_compartment_id
  workload_compartment_id    = var.workload_compartment_id

  is_create_alarms         = var.is_create_alarms
  network_topic_endpoints  = var.network_topic_endpoints
  secops_topic_endpoints   = var.secops_topic_endpoints
  platform_topic_endpoints = var.platform_topic_endpoints
  identity_topic_endpoints = var.identity_topic_endpoints
  default_log_group_id     = module.logging.log_group_id

  workload_topic_endpoints = var.workload_topic_endpoints

  enable_security_monitoring_alarms = var.enable_security_monitoring_alarms
  enable_network_monitoring_alarms  = var.enable_network_monitoring_alarms
  enable_workload_monitoring_alarms = var.enable_workload_monitoring_alarms

  providers = {
    oci               = oci
    oci.backup_region = oci.backup_region
  }
}