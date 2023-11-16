locals {
  audit_log_bucket = {
    name                                = "${var.resource_label}_${var.environment_prefix}_backup_auditLogs_standard"
    description                         = "Audit Log bucket for backup region"
    retention_rule_display_name         = "audit log bucket retention rule"
    retention_policy_duration_amount    = var.retention_policy_duration_amount
    retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
    bucket_storage_tier                 = "Standard"
  }

  default_log_bucket = {
    name                                = "${var.resource_label}_${var.environment_prefix}_backup_defaultLogs_standard"
    description                         = "Default Log bucket for backup region"
    retention_rule_display_name         = "default log bucket retention rule"
    retention_policy_duration_amount    = var.retention_policy_duration_amount
    retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
    bucket_storage_tier                 = "Standard"
  }

  service_event_log_bucket = {
    name                                = "${var.resource_label}_${var.environment_prefix}_backup_serviceEvents_standard"
    description                         = "Service Events Log bucket for backup region"
    retention_rule_display_name         = "service events log bucket retention rule"
    retention_policy_duration_amount    = var.retention_policy_duration_amount
    retention_policy_duration_time_unit = var.retention_policy_duration_time_unit
    bucket_storage_tier                 = "Standard"
  }
}
module "audit_log_bucket" {
  source                              = "../../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = var.logging_compartment_id
  name                                = local.audit_log_bucket.name
  kms_key_id                          = var.master_encryption_key
  storage_tier                        = local.audit_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.audit_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.audit_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.audit_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace
  providers = {
    oci = oci.backup_region
  }
}

module "default_log_bucket" {

  source                              = "../../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = var.logging_compartment_id
  name                                = local.default_log_bucket.name
  kms_key_id                          = var.master_encryption_key
  storage_tier                        = local.default_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.default_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.default_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.default_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace
  providers = {
    oci = oci.backup_region
  }
}

module "service_event_log_bucket" {
  source                              = "../../../modules/bucket"
  tenancy_ocid                        = var.tenancy_ocid
  compartment_id                      = var.logging_compartment_id
  name                                = local.service_event_log_bucket.name
  kms_key_id                          = var.master_encryption_key
  storage_tier                        = local.service_event_log_bucket.bucket_storage_tier
  retention_rule_display_name         = local.service_event_log_bucket.retention_rule_display_name
  retention_policy_duration_amount    = local.service_event_log_bucket.retention_policy_duration_amount
  retention_policy_duration_time_unit = local.service_event_log_bucket.retention_policy_duration_time_unit
  namespace                           = data.oci_objectstorage_namespace.ns.namespace
  providers = {
    oci = oci.backup_region
  }
}