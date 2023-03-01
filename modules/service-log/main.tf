terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_logging_log" "service_log" {
  for_each = var.service_log_map
  display_name = "${var.log_display_name}-${each.key}"
  log_group_id = var.log_group_id
  log_type = var.log_type

  configuration {
    source {
      category = var.log_source_category
      resource = each.value
      service = var.log_source_service
      source_type = var.log_source_type
    }
  }
}
