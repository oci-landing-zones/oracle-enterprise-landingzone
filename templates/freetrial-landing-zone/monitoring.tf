locals {
  logging_analytics = {
    is_onboarded = true
  }
}

module "logging_analytics_namespace" {
  count          = var.onboard_log_analytics ? 1 : 0
  source         = "../../modules/log-analytics-namespace"
  compartment_id = var.tenancy_ocid
  is_onboarded   = local.logging_analytics.is_onboarded
  tenancy_ocid   = var.tenancy_ocid
  resource_label = var.resource_label
}
