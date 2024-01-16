##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

locals {
  default_log_group = {
    name        = "Default_Group"
    description = "Default log group for ${var.home_compartment_name}"
  }

  service_event_stream = {
    stream_pool_name       = "services-events-pool"
    stream_name            = "serviceEvents"
    stream_partitions      = 1
    rule_action_type       = "OSS"
    rule_action_is_enabled = true
    rule_condition         = "{ }" // MATCH ALL EVENTS IN THIS COMPARTMENT HIERARCHY
    rule_display_name      = "All events in ${var.home_compartment_name}"
    rule_is_enabled        = true
  }

  audit_log_bucket = {
    name                                = "${var.resource_label}_${var.environment_prefix}_auditLogs_standard"
    description                         = "Audit Log bucket"
    retention_rule_display_name         = "audit log bucket retention rule"
    retention_policy_duration_amount    = var.retention_policy_duration_amount
    retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
    bucket_storage_tier                 = "Standard"
  }

  default_log_bucket = {
    name                                = "${var.resource_label}_${var.environment_prefix}_defaultLogs_standard"
    description                         = "Default Log bucket"
    retention_rule_display_name         = "default log bucket retention rule"
    retention_policy_duration_amount    = var.retention_policy_duration_amount
    retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
    bucket_storage_tier                 = "Standard"
  }

  service_event_log_bucket = {
    name                                = "${var.resource_label}_${var.environment_prefix}_serviceEvents_standard"
    description                         = "Service Events Log bucket"
    retention_rule_display_name         = "service events log bucket retention rule"
    retention_policy_duration_amount    = var.retention_policy_duration_amount
    retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
    bucket_storage_tier                 = "Standard"
  }

  audit_log_service_connector = {
    display_name  = "${var.resource_label}_${var.environment_prefix}_defaultLogs_standard"
    source_kind   = "logging"
    target_kind   = "objectStorage"
    log_group_id  = "_Audit_Include_Subcompartment"
    target_bucket = local.audit_log_bucket.name
  }

  default_log_service_connector = {
    display_name  = "${var.resource_label}_${var.environment_prefix}_auditLogs_standard"
    source_kind   = "logging"
    target_kind   = "objectStorage"
    target_bucket = local.default_log_bucket.name
  }

  service_events_service_connector = {
    display_name  = "${var.resource_label}_${var.environment_prefix}_serviceEvents_standard"
    source_kind   = "streaming"
    target_kind   = "objectStorage"
    target_bucket = local.service_event_log_bucket.name
    cursor_kind   = "TRIM_HORIZON"
  }

  buckets_map = {
    DEFAULT : "${var.resource_label}_${var.environment_prefix}_defaultLogs_standard",
    AUDIT: "${var.resource_label}_${var.environment_prefix}_auditLogs_standard",
    SERVICE_EVENT: "${var.resource_label}_${var.environment_prefix}_serviceEvents_standard"
  }
  buckets_map_service_conector_limit = {
    SERVICE_EVENT: "${var.resource_label}_${var.environment_prefix}_serviceEvents_standard"
  }

  os_read_log = {
    log_display_name    = "${var.resource_label}-OCI-ELZ-OS-READ-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_resource = "${var.resource_label}_${var.environment_prefix}_serviceEvents_standard"
    log_source_category = "read"
    log_source_service  = "objectstorage"
    log_source_type     = "OCISERVICE"
  }

  os_write_log = {
    log_display_name    = "${var.resource_label}-OCI-ELZ-OS-WRITE-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_resource = "${var.resource_label}_${var.environment_prefix}_serviceEvents_standard"
    log_source_category = "write"
    log_source_service  = "objectstorage"
    log_source_type     = "OCISERVICE"
  }

  subnets_map = {
    HUB1: var.subnets_map["OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}001"]
    HUB2: var.subnets_map["OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}002"]
    SKP1: var.subnets_map["OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}001"]
    SKP2: var.subnets_map["OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}002"]
    SKP3: var.subnets_map["OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}003"]
  }

  vcn_flow_log = {
    log_display_name    = "${var.resource_label}-OCI-ELZ-VCN-FLOW-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_category = "all"
    log_source_service  = "flowlogs"
    log_source_type     = "OCISERVICE"
  }

  events_map = {
    security : data.oci_events_rules.security_event_rules.rules[0].id # All event in the LZ home compartment
  }

  event_log = {
    log_display_name    = "${var.resource_label}-OCI-ELZ-EVENT-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_category = "ruleexecutionlog"
    log_source_service  = "cloudevents"
    log_source_type     = "OCISERVICE"
  }
}

module "default_log_group" {
  source         = "../../modules/log-group"
  compartment_id = var.security_compartment_id
  display_name   = local.default_log_group.name
  description    = local.default_log_group.description
}

module "service_event_stream" {
  source                 = "../../modules/stream"
  compartment_id         = var.security_compartment_id
  stream_pool_name       = local.service_event_stream.stream_pool_name
  stream_name            = local.service_event_stream.stream_name
  kms_key_id             = var.master_encryption_key
  stream_partitions      = local.service_event_stream.stream_partitions
  rule_action_type       = local.service_event_stream.rule_action_type
  rule_action_is_enabled = local.service_event_stream.rule_action_is_enabled
  rule_condition         = local.service_event_stream.rule_condition
  rule_display_name      = local.service_event_stream.rule_display_name
  rule_is_enabled        = local.service_event_stream.rule_is_enabled
}

module "audit_log_bucket" {
  count                               = var.is_service_connector_limit   ? 0 : 1
  source                              = "../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = var.logging_compartment_id
  name                                = local.audit_log_bucket.name
  kms_key_id                          = var.master_encryption_key
  storage_tier                        = local.audit_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.audit_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.audit_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.audit_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace
}

module "default_log_bucket" {
  count                               = var.is_service_connector_limit   ? 0 : 1
  source                              = "../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = var.logging_compartment_id
  name                                = local.default_log_bucket.name
  kms_key_id                          = var.master_encryption_key
  storage_tier                        = local.default_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.default_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.default_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.default_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace
}

module "service_event_log_bucket" {
  source                              = "../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = var.logging_compartment_id
  name                                = local.service_event_log_bucket.name
  kms_key_id                          = var.master_encryption_key
  storage_tier                        = local.service_event_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.service_event_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.service_event_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.service_event_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace
}

module "audit_log_service_connector" {
  count                 = var.is_service_connector_limit   ? 0 : 1
  source                = "../../modules/service-connector"
  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = var.security_compartment_id
  source_compartment_id = var.home_compartment_id
  display_name          = local.audit_log_service_connector.display_name
  source_kind           = local.audit_log_service_connector.source_kind
  target_kind           = local.audit_log_service_connector.target_kind
  log_group_id          = local.audit_log_service_connector.log_group_id
  target_bucket         = local.audit_log_service_connector.target_bucket

  depends_on = [module.audit_log_bucket]
}

module "default_log_service_connector" {
  count                 = var.is_service_connector_limit   ? 0 : 1
  source                = "../../modules/service-connector"
  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = var.security_compartment_id
  source_compartment_id = var.security_compartment_id
  display_name          = local.default_log_service_connector.display_name
  source_kind           = local.default_log_service_connector.source_kind
  target_kind           = local.default_log_service_connector.target_kind
  log_group_id          = module.default_log_group.log_group_id
  target_bucket         = local.default_log_service_connector.target_bucket
  # Service connector needs at least one log on the log group, or it errors.
  # Also it takes time for it to recognize this.
  depends_on = [module.default_log_bucket, module.default_log_group, time_sleep.first_log_delay]
}


module "service_events_service_connector" {
  source                = "../../modules/service-connector"
  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = var.security_compartment_id
  source_compartment_id = var.security_compartment_id
  display_name          = local.service_events_service_connector.display_name
  source_kind           = local.service_events_service_connector.source_kind
  target_kind           = local.service_events_service_connector.target_kind
  stream_id             = module.service_event_stream.stream_id
  cursor_kind           = local.service_events_service_connector.cursor_kind
  target_bucket         = local.service_events_service_connector.target_bucket

  depends_on = [module.service_event_log_bucket]
}

resource "time_sleep" "first_log_delay" {
  create_duration = "600s"
}

module "os_read_log" {
  source = "../../modules/service-log"

  log_display_name    = local.os_read_log.log_display_name
  log_type            = local.os_read_log.log_type
  log_group_id        = module.default_log_group.log_group_id
  log_source_category = local.os_read_log.log_source_category
  log_source_resource = local.os_read_log.log_source_resource
  log_source_service  = local.os_read_log.log_source_service
  log_source_type     = local.os_read_log.log_source_type

  depends_on = [ module.audit_log_bucket, module.default_log_bucket, module.service_event_log_bucket, module.default_log_group ]
}

module "os_write_log" {
  source = "../../modules/service-log"

  log_display_name    = local.os_write_log.log_display_name
  log_type            = local.os_write_log.log_type
  log_group_id        = module.default_log_group.log_group_id
  log_source_category = local.os_write_log.log_source_category
  log_source_resource = local.os_write_log.log_source_resource
  log_source_service  = local.os_write_log.log_source_service
  log_source_type     = local.os_write_log.log_source_type

  depends_on = [ module.audit_log_bucket, module.default_log_bucket, module.service_event_log_bucket, module.default_log_group ]
}


module "vcn_flow_log" {
  source = "../../modules/service-log-map"

  service_log_map     = local.subnets_map
  log_display_name    = local.vcn_flow_log.log_display_name
  log_type            = local.vcn_flow_log.log_type
  log_group_id        = module.default_log_group.log_group_id
  log_source_category = local.vcn_flow_log.log_source_category
  log_source_service  = local.vcn_flow_log.log_source_service
  log_source_type     = local.vcn_flow_log.log_source_type
}

module "event_log" {
  source = "../../modules/service-log-map"

  service_log_map     = local.events_map
  log_display_name    = local.event_log.log_display_name
  log_type            = local.event_log.log_type
  log_group_id        = module.default_log_group.log_group_id
  log_source_category = local.event_log.log_source_category
  log_source_service  = local.event_log.log_source_service
  log_source_type     = local.event_log.log_source_type

  depends_on = [module.service_event_stream]
}

