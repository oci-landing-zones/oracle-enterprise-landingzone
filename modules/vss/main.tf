terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_vulnerability_scanning_host_scan_recipe" "vss_host_scan_recipe" {
  compartment_id = var.recipe_compartment_ocid
  display_name   = var.host_scan_recipe_display_name

  agent_settings {
    scan_level = var.host_scan_recipe_agent_settings_scan_level

    agent_configuration {
      vendor = var.host_scan_recipe_agent_settings_agent_configuration_vendor
      cis_benchmark_settings {
        scan_level = var.agent_cis_benchmark_settings_scan_level
      }
    }
  }

  port_settings {
    scan_level = var.host_scan_recipe_port_settings_scan_level
  }

  schedule {
    type = var.vss_scan_schedule
  }
}

resource "oci_vulnerability_scanning_host_scan_target" "vss_host_scan_target" {
  compartment_id        = var.target_compartment_ocid
  host_scan_recipe_id   = oci_vulnerability_scanning_host_scan_recipe.vss_host_scan_recipe.id
  target_compartment_id = var.target_compartment_ocid
  description           = var.host_scan_target_description
  display_name          = var.host_scan_target_display_name

  depends_on = [oci_vulnerability_scanning_host_scan_target.vss_host_scan_target]
}