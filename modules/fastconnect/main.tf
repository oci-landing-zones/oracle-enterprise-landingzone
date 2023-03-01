terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}
locals {
  fastconnect_asn_provider_list    = split(",", var.fastconnect_asn_provider_list)
  fastconnect_no_asn_provider_list = split(",", var.fastconnect_no_asn_provider_list)
}

# -----------------------------------------------------------------------------
# Create FastConnect virtual circuit for Azure ExpressRoute
# -----------------------------------------------------------------------------
resource "oci_core_virtual_circuit" "azure_fastconnect_virtual_circuit" {
  count                     = var.fastconnect_provider == "Azure" ? 1 : 0
  compartment_id            = var.compartment_ocid
  gateway_id                = var.drg_id
  bandwidth_shape_name      = var.virtual_circuit_bandwidth_shape
  display_name              = var.virtual_circuit_display_name
  provider_service_id       = data.oci_core_fast_connect_provider_service.fast_connect_provider_service.id
  provider_service_key_name = var.provider_service_key_name
  region                    = var.region_key
  routing_policy            = var.fastconnect_routing_policy
  type                      = var.virtual_circuit_type
  is_bfd_enabled            = var.virtual_circuit_is_bfd_enabled
  cross_connect_mappings {
    bgp_md5auth_key         = var.bgp_md5auth_key
    customer_bgp_peering_ip = var.customer_primary_bgp_peering_ip
    oracle_bgp_peering_ip   = var.oracle_primary_bgp_peering_ip
  }
  cross_connect_mappings {
    bgp_md5auth_key         = var.bgp_md5auth_key
    customer_bgp_peering_ip = var.customer_secondary_bgp_peering_ip
    oracle_bgp_peering_ip   = var.oracle_secondary_bgp_peering_ip
  }
}

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create FastConnect virtual circuit for Megaport/QTS/C3ntro/Cologix/CoreSite/Digital Realty/EdgeConneX/Epsilon/Equinix/InterCloud/Lumen/Neutrona/OracleL2ItegDeployment/Zayo
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "oci_core_virtual_circuit" "fastconnect_asn_virtual_circuit" {
  count                = contains(local.fastconnect_asn_provider_list, var.fastconnect_provider) ? 1 : 0
  compartment_id       = var.compartment_ocid
  customer_asn         = var.virtual_circuit_customer_asn
  gateway_id           = var.drg_id
  bandwidth_shape_name = var.virtual_circuit_bandwidth_shape
  display_name         = var.virtual_circuit_display_name
  provider_service_id  = data.oci_core_fast_connect_provider_service.fast_connect_provider_service.id
  region               = var.region_key
  routing_policy       = var.fastconnect_routing_policy
  type                 = var.virtual_circuit_type
  is_bfd_enabled       = var.virtual_circuit_is_bfd_enabled
  cross_connect_mappings {
    bgp_md5auth_key         = var.bgp_md5auth_key
    customer_bgp_peering_ip = var.customer_primary_bgp_peering_ip
    oracle_bgp_peering_ip   = var.oracle_primary_bgp_peering_ip
  }
}

# -----------------------------------------------------------------------------------------
# Create FastConnect virtual circuit for AT&T/Verizon/BT/OMCS/OracleL3ItegDeployment/Orange
# -----------------------------------------------------------------------------------------
resource "oci_core_virtual_circuit" "fastconnect_no_asn_virtual_circuit" {
  count                = contains(local.fastconnect_no_asn_provider_list, var.fastconnect_provider) ? 1 : 0
  compartment_id       = var.compartment_ocid
  gateway_id           = var.drg_id
  bandwidth_shape_name = var.virtual_circuit_bandwidth_shape
  display_name         = var.virtual_circuit_display_name
  provider_service_id  = data.oci_core_fast_connect_provider_service.fast_connect_provider_service.id
  region               = var.region_key
  routing_policy       = var.fastconnect_routing_policy
  type                 = var.virtual_circuit_type
  is_bfd_enabled       = var.virtual_circuit_is_bfd_enabled
}

# -----------------------------------------------------------------------------------------
# Create Virtual Circuit DRG Attachment
# -----------------------------------------------------------------------------------------
resource "oci_core_drg_attachment_management" "drg_vc_attachment_azure" {
  count              = var.fastconnect_provider == "Azure" ? 1 : 0
  attachment_type    = "VIRTUAL_CIRCUIT"
  compartment_id     = var.compartment_ocid
  network_id         = oci_core_virtual_circuit.azure_fastconnect_virtual_circuit[0].id
  drg_id             = var.drg_id
  display_name       = "P-VC-Attachment"
  drg_route_table_id = var.drg_route_table_vc_id
}

resource "oci_core_drg_attachment_management" "drg_vc_attachment_asn" {
  count              = contains(local.fastconnect_asn_provider_list, var.fastconnect_provider) ? 1 : 0
  attachment_type    = "VIRTUAL_CIRCUIT"
  compartment_id     = var.compartment_ocid
  network_id         = oci_core_virtual_circuit.fastconnect_asn_virtual_circuit[0].id
  drg_id             = var.drg_id
  display_name       = "P-VC-Attachment"
  drg_route_table_id = var.drg_route_table_vc_id
}

resource "oci_core_drg_attachment_management" "drg_vc_attachment_no_asn" {
  count              = contains(local.fastconnect_no_asn_provider_list, var.fastconnect_provider) ? 1 : 0
  attachment_type    = "VIRTUAL_CIRCUIT"
  compartment_id     = var.compartment_ocid
  network_id         = oci_core_virtual_circuit.fastconnect_no_asn_virtual_circuit[0].id
  drg_id             = var.drg_id
  display_name       = "P-VC-Attachment"
  drg_route_table_id = var.drg_route_table_vc_id
}