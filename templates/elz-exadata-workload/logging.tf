##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

locals {
  vcn_flow_log = {
    log_display_name    = "${var.resource_label}-OCI-ELZ-VCN-FLOW-LOG-${var.environment_prefix}-${var.workload_name}"
    log_type            = "SERVICE"
    log_source_category = "all"
    log_source_service  = "flowlogs"
    log_source_type     = "OCISERVICE"
  }
  wrk_private_spoke_subnet_lb_display_name     = var.workload_private_spoke_subnet_lb_display_name != "" ? var.workload_private_spoke_subnet_lb_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-LB"
  wrk_private_spoke_subnet_app_display_name    = var.workload_private_spoke_subnet_app_display_name != "" ? var.workload_private_spoke_subnet_app_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-APP"
  wrk_private_spoke_subnet_client_display_name = var.workload_private_spoke_subnet_client_display_name != "" ? var.workload_private_spoke_subnet_client_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-CLT"
  wrk_private_spoke_subnet_backup_display_name = var.workload_private_spoke_subnet_backup_display_name != "" ? var.workload_private_spoke_subnet_backup_display_name : "OCI-ELZ-${var.workload_prefix}-EXA-SPK-SUB-${local.region_key[0]}-BKP"

  subnets_map = {
    SPK1 : module.exadata_workload_expansion_spoke.subnets[local.wrk_private_spoke_subnet_lb_display_name]
    SPK2 : module.exadata_workload_expansion_spoke.subnets[local.wrk_private_spoke_subnet_app_display_name]
    SPK3 : module.exadata_workload_expansion_spoke.subnets[local.wrk_private_spoke_subnet_client_display_name]
    SPK4 : module.exadata_workload_expansion_spoke.subnets[local.wrk_private_spoke_subnet_backup_display_name]
  }

}

module "vcn_flow_log" {
  source = "../../modules/service-log-map"

  service_log_map     = local.subnets_map
  log_display_name    = local.vcn_flow_log.log_display_name
  log_type            = local.vcn_flow_log.log_type
  log_group_id        = var.default_log_group_id
  log_source_category = local.vcn_flow_log.log_source_category
  log_source_service  = local.vcn_flow_log.log_source_service
  log_source_type     = local.vcn_flow_log.log_source_type
}
