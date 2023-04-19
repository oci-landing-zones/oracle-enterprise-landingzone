terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}
######################################################################
#                 Create VCN NAT Gateway                             # 
######################################################################

resource "oci_core_nat_gateway" "nat_gw" {
  

  compartment_id  = var.nat_network_compartment_id
  vcn_id          = var.nat_vcn_id
  display_name    = var.nat_gateway_display_name

  count = var.create_nat_gateway == true ? 1 : 0
}

######################################################################
#                 Create VCN Setvice Gateway                         # 
######################################################################

data "oci_core_services" "service_gateway_all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

resource "oci_core_service_gateway" "service_gw" {

  compartment_id = var.sgw_network_compartment_id
  vcn_id          = var.sgw_vcn_id
  services {
        service_id = lookup(data.oci_core_services.service_gateway_all_oci_services.services[0], "id")
  }
  display_name = var.service_gateway_display_name
  
  count = var.create_service_gateway == true ? 1 : 0
}