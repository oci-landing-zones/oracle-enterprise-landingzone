data "oci_core_fast_connect_provider_services" "fast_connect_provider_services" {
  compartment_id = var.compartment_ocid
}

data "oci_core_fast_connect_provider_service" "fast_connect_provider_service" {
  provider_service_id = lookup(element(data.oci_core_fast_connect_provider_services.fast_connect_provider_services.fast_connect_provider_services, index(data.oci_core_fast_connect_provider_services.fast_connect_provider_services.fast_connect_provider_services.*.provider_name, var.fastconnect_provider)), "id")
}
