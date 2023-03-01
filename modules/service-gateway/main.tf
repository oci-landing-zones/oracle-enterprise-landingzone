terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# -----------------------------------------------------------------------------
# Create Service Gateway
# -----------------------------------------------------------------------------

data "oci_core_services" "service_gateway_all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}


resource "oci_core_service_gateway" "service_gateway_all_svcs" {
  compartment_id = var.network_compartment_id
  vcn_id          = var.vcn_id
  services {
        service_id = lookup(data.oci_core_services.service_gateway_all_oci_services.services[0], "id")
  }
  display_name = var.service_gateway_display_name
}

