##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

data "oci_core_fast_connect_provider_services" "fast_connect_provider_services" {
  compartment_id = var.compartment_ocid
}

data "oci_core_fast_connect_provider_service" "fast_connect_provider_service" {
  provider_service_id = lookup(element(data.oci_core_fast_connect_provider_services.fast_connect_provider_services.fast_connect_provider_services, index(data.oci_core_fast_connect_provider_services.fast_connect_provider_services.fast_connect_provider_services.*.provider_name, var.fastconnect_provider)), "id")
}
