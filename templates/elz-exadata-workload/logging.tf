
locals {
  vcn_flow_log = {
    log_display_name    = "${var.resource_label}-OCI-ELZ-VCN-FLOW-LOG-${var.environment_prefix}-${var.workload_name}"
    log_type            = "SERVICE"
    log_source_category = "all"
    log_source_service  = "flowlogs"
    log_source_type     = "OCISERVICE"
  }

  subnets_map = {
    SPK1 : module.exadata_workload_expansion_spoke.subnets["OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-LB"]
    SPK2 : module.exadata_workload_expansion_spoke.subnets["OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-APP"]
    SPK3 : module.exadata_workload_expansion_spoke.subnets["OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-CLT"]
    SPK4 : module.exadata_workload_expansion_spoke.subnets["OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-BKP"]
  }

}

module "vcn_flow_log" {
  source = "../../modules/service-log"

  service_log_map     = local.subnets_map
  log_display_name    = local.vcn_flow_log.log_display_name
  log_type            = local.vcn_flow_log.log_type
  log_group_id        = var.default_log_group_id
  log_source_category = local.vcn_flow_log.log_source_category
  log_source_service  = local.vcn_flow_log.log_source_service
  log_source_type     = local.vcn_flow_log.log_source_type
}
