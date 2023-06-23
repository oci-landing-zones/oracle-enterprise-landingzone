terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_sch_service_connector" "service_connector" {
  compartment_id = var.compartment_id
  display_name = var.display_name
  source {
    kind = var.source_kind

    log_sources {
      compartment_id = var.source_compartment_id
      log_group_id = var.log_group_id
    }
    cursor {
      kind = var.cursor_kind
    }

    stream_id = var.stream_id

  }
  target {
    kind = var.target_kind
    bucket = var.target_bucket
    namespace = data.oci_objectstorage_namespace.ns.namespace
  }
  lifecycle {
    ignore_changes = [ 
      source[0].stream_id 
    ]
  }
}