terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_log_analytics_log_analytics_log_group" "log_analytics_log_group" {
  compartment_id = var.compartment_id
  display_name   = var.log_group_display_name
  namespace      = data.oci_log_analytics_namespaces.logging_analytics_namespaces.namespace_collection[0].items[0].namespace
  description    = var.log_group_description
}

locals {
  service_connector = {
    target_kind = "loggingAnalytics"
  }
}
resource "oci_sch_service_connector" "service_connector" {
  compartment_id = var.compartment_id
  display_name   = var.service_connector_display_name

  source {
    kind = var.service_connector_source_kind
    log_sources {
      compartment_id = var.service_connector_source_compartment_id
      log_group_id   = var.service_connector_source_log_group_id
    }
  }

  target {
    kind         = local.service_connector.target_kind
    log_group_id = oci_log_analytics_log_analytics_log_group.log_analytics_log_group.id
  }
}

locals {
  policy = {
    name        = "lzSchPolicy${var.log_group_display_name}"
    description = "Policy allowing log upload to service connectors in security compartment."
    statements = [
      <<EOT
      allow any-user to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment id ${var.compartment_id} where all
      {
        request.principal.type='serviceconnector',
        target.loganalytics-log-group.id='${oci_log_analytics_log_analytics_log_group.log_analytics_log_group.id}',
        request.principal.compartment.id='${var.compartment_id}'
      }
      EOT
    ]
  }
}
resource "oci_identity_policy" "policy" {
  compartment_id = var.compartment_id
  description    = local.policy.description
  name           = local.policy.name
  statements     = local.policy.statements
}
