locals {
  service_connector_policy = {
    name        = "${var.resource_label}-OCI-ELZ-SC-Policy"
    description = "OCI ELZ Service Connector Policy"
    statements = [
      "Allow any-user to read log-content in compartment id ${module.home_compartment.compartment_id} where all {request.principal.type='serviceconnector'}",
      "Allow any-user to read log-groups in compartment id ${module.home_compartment.compartment_id} where all {request.principal.type='serviceconnector'}",
      "Allow any-user to {STREAM_READ, STREAM_CONSUME} in compartment id ${module.prod_environment.compartment.security.id} where all {request.principal.type='serviceconnector', target.stream.id='${module.prod_environment.stream_id}', request.principal.compartment.id='${module.prod_environment.compartment.security.id}'}",
      "Allow any-user to manage objects in compartment id ${module.prod_environment.compartment.logging.id} where all {request.principal.type='serviceconnector', target.bucket.name='*_standard', request.principal.compartment.id='${module.prod_environment.compartment.security.id}'}",
      "Allow any-user to manage objects in compartment id ${module.prod_environment.compartment.logging.id} where all {request.principal.type='serviceconnector', any{target.bucket.name='${var.resource_label}_${local.prod_environment.environment_prefix}_auditLogs_standard', target.bucket.name='${var.resource_label}_${local.prod_environment.environment_prefix}_defaultLogs_standard', target.bucket.name='${var.resource_label}_${local.prod_environment.environment_prefix}_serviceEvents_standard'}, request.principal.compartment.id='${module.prod_environment.compartment.security.id}'}",
    ]
  }


  service_connector_archive_policy = {
    name        = "${var.resource_label}-OCI-ELZ-SC-ARC-Policy"
    description = "OCI ELZ Service Connector Policy For Archive"
    statements = [
      "Allow any-user to read log-content in compartment id ${module.home_compartment.compartment_id} where all {request.principal.type='serviceconnector'}",
      "Allow any-user to read log-groups in compartment id ${module.home_compartment.compartment_id} where all {request.principal.type='serviceconnector'}",
      "Allow any-user to {STREAM_READ, STREAM_CONSUME} in compartment id ${module.home_compartment.compartment_id} where all {request.principal.type='serviceconnector'}",
      "Allow any-user to manage objects in compartment id ${module.home_compartment.compartment_id} where all {request.principal.type='serviceconnector', target.bucket.name='${local.archive_log_bucket.name}'}"
    ]
  }

  key_archive_policy = {
    name        = "${var.resource_label}-OCI-ELZ-KEY-ARC-Policy"
    description = "OCI Enterprise Landing Zone Key Policy For Archive"

    statements = [
      "Allow service objectstorage-${var.region} to use keys in compartment id ${module.prod_environment.compartment.security.id}",
      "Allow service blockstorage,FssOc1Prod, OKE, streaming to use keys in compartment id ${module.prod_environment.compartment.security.id}"
    ]
  }

  archive_log_bucket = {
    name                                = "${var.resource_label}_logs_archive"
    description                         = "Archive Log bucket"
    retention_rule_display_name         = "archive log bucket retention rule"
    retention_policy_duration_amount    = var.archive_log_retention_policy_duration_amount
    retention_policy_duration_time_unit = var.archive_log_retention_policy_duration_time_unit
    bucket_storage_tier                 = "Archive"
  }

  prod_archive_audit_log_service_connector = {
    display_name  = "${var.resource_label}_schAuditLog_archive_${local.prod_environment.environment_prefix}"
    source_kind   = "logging"
    target_kind   = "objectStorage"
    log_group_id  = "_Audit_Include_Subcompartment"
    target_bucket = module.archive_bucket.bucket.name
  }

  prod_archive_default_log_service_connector = {
    display_name  = "${var.resource_label}_schDefaultLog_archive_${local.prod_environment.environment_prefix}"
    source_kind   = "logging"
    target_kind   = "objectStorage"
    target_bucket = module.archive_bucket.bucket.name
  }

  prod_archive_service_events_service_connector = {
    display_name  = "${var.resource_label}_schServiceEvents_archive_${local.prod_environment.environment_prefix}"
    source_kind   = "streaming"
    target_kind   = "objectStorage"
    target_bucket = module.archive_bucket.bucket.name
    cursor_kind   = "TRIM_HORIZON"
  }

  archive_key = {
    name = "${var.resource_label}-OCI-ELZ-ARC-KEY-${local.prod_environment.environment_prefix}"
    shape_algorithm = "AES"
    shape_length = 32
    protection_mode = "SOFTWARE"
  }

  group_names = {
    prod_platform_admin_group_name : var.prod_platform_admin_group_name != "" ? var.prod_platform_admin_group_name : "OCI-ELZ-UGP-${local.prod_environment.environment_prefix}-PLT-ADMIN",
    nonprod_platform_admin_group_name : var.nonprod_platform_admin_group_name != "" ? var.nonprod_platform_admin_group_name : "OCI-ELZ-UGP-${local.prod_environment.environment_prefix}-PLT-ADMIN",
  }

  prod_platform_admin_policy = {
    name        = "OCI-ELZ-UGP-${local.prod_environment.environment_prefix}-PLT-ADMIN-POLICY-ARCHIVE"
    description = "OCI Landing Zone Platform Admin Group Policy To Manage Archive Bucket"

    statements = [
      "Allow group ${local.group_names["prod_platform_admin_group_name"]} to manage buckets in compartment ${module.home_compartment.compartment_name}",
      "Allow group ${local.group_names["prod_platform_admin_group_name"]} to manage objects in compartment ${module.home_compartment.compartment_name}"
    ]
  }
}
module "service_connector_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.service_connector_policy.name
  description      = local.service_connector_policy.description
  statements       = local.service_connector_policy.statements

  depends_on = [module.prod_environment, module.home_compartment]
}

module "service_connector_archive_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.service_connector_archive_policy.name
  description      = local.service_connector_archive_policy.description
  statements       = local.service_connector_archive_policy.statements

  depends_on = [module.prod_environment, module.home_compartment]
}

module "archive_key" {
  source = "../../modules/key"
  compartment_ocid    = module.prod_environment.compartment.security.id
  display_name        = local.archive_key.name
  shape_algorithm     = local.archive_key.shape_algorithm
  shape_length        = local.archive_key.shape_length
  protection_mode     = local.archive_key.protection_mode
  management_endpoint = module.prod_environment.vault_id

  depends_on = [module.prod_environment, module.home_compartment]
}

module "key_archive_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.key_archive_policy.name
  description      = local.key_archive_policy.description
  statements       = local.key_archive_policy.statements

  depends_on = [module.prod_environment, module.home_compartment]
}

module "archive_bucket" {
  source                              = "../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = module.home_compartment.compartment_id
  name                                = local.archive_log_bucket.name
  kms_key_id                          = module.archive_key.key_ocid
  storage_tier                        = local.archive_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.archive_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.archive_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.archive_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace

  depends_on = [module.prod_environment, module.home_compartment, module.archive_key, module.key_archive_policy]
}

module "prod_archive_audit_log_service_connector" {
  count                 = var.is_service_connector_limit   ? 0 : 1

  source                = "../../modules/service-connector"
  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = module.prod_environment.compartment.security.id
  source_compartment_id = module.home_compartment.compartment_id
  display_name          = local.prod_archive_audit_log_service_connector.display_name
  source_kind           = local.prod_archive_audit_log_service_connector.source_kind
  target_kind           = local.prod_archive_audit_log_service_connector.target_kind
  log_group_id          = local.prod_archive_audit_log_service_connector.log_group_id
  target_bucket         = local.prod_archive_audit_log_service_connector.target_bucket

  depends_on = [module.archive_bucket, module.service_connector_archive_policy]
}
module "prod_archive_default_log_service_connector" {
  count                 = var.is_service_connector_limit   ? 0 : 1
  source                = "../../modules/service-connector"

  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = module.prod_environment.compartment.security.id
  source_compartment_id = module.prod_environment.compartment.security.id
  display_name          = local.prod_archive_default_log_service_connector.display_name
  source_kind           = local.prod_archive_default_log_service_connector.source_kind
  target_kind           = local.prod_archive_default_log_service_connector.target_kind
  log_group_id          = module.prod_environment.default_group_id
  target_bucket         = local.prod_archive_default_log_service_connector.target_bucket

  depends_on = [module.archive_bucket, module.service_connector_archive_policy]
}
module "prod_archive_service_events_service_connector" {
  source                = "../../modules/service-connector"
  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = module.prod_environment.compartment.security.id
  source_compartment_id = module.prod_environment.compartment.security.id
  display_name          = local.prod_archive_service_events_service_connector.display_name
  source_kind           = local.prod_archive_service_events_service_connector.source_kind
  target_kind           = local.prod_archive_service_events_service_connector.target_kind
  stream_id             = module.prod_environment.stream_id
  cursor_kind           = local.prod_archive_service_events_service_connector.cursor_kind
  target_bucket         = local.prod_archive_service_events_service_connector.target_bucket

  depends_on = [module.archive_bucket, module.service_connector_archive_policy]
}
module "prod_platform_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.prod_platform_admin_policy.name
  description      = local.prod_platform_admin_policy.description
  statements       = local.prod_platform_admin_policy.statements

  depends_on = [module.home_compartment]
}

