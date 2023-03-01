terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}


# -----------------------------------------------------------------------------
# Create customer premises equipment object
# -----------------------------------------------------------------------------
resource "oci_core_cpe" "oci-ipsec-cpe" {
  compartment_id      = var.compartment_ocid
  ip_address          = var.cpe_ip_address
  cpe_device_shape_id = data.oci_core_cpe_device_shape.oci-ipsec-cpe-device-shape.id
  display_name        = var.cpe_display_name
}

# -----------------------------------------------------------------------------
# Create IPSec tunnel connection for site-to-site VPN
# -----------------------------------------------------------------------------
resource "oci_core_ipsec" "oci-ipsec-connection" {
  compartment_id = var.compartment_ocid
  cpe_id         = oci_core_cpe.oci-ipsec-cpe.id
  drg_id         = var.drg_id
  display_name   = var.ipsec_display_name
  static_routes  = var.static_routes
}

# -----------------------------------------------------------------------------
# Create IPSEC connection management for OCI VCN tunnel a
# -----------------------------------------------------------------------------
resource "oci_core_ipsec_connection_tunnel_management" "oci-ipsec-connection-tunnel-management-a" {
  ipsec_id      = oci_core_ipsec.oci-ipsec-connection.id
  tunnel_id     = data.oci_core_ipsec_connection_tunnels.oci-ipsec-connection-tunnels.ip_sec_connection_tunnels[0].id
  routing       = var.routing
  display_name  = var.tunnel_a_display_name

  #Optional
  bgp_session_info {
    customer_bgp_asn      = var.routing == "BGP" ? var.customer_bgp_asn : null
    customer_interface_ip = var.routing == "BGP" ? var.bgp_cust_tunnela_ip : null
    oracle_interface_ip   = var.routing == "BGP" ? var.bgp_oci_tunnela_ip : null
  }

  shared_secret = var.shared_secret
  ike_version   = "V1"

  depends_on    = [data.oci_core_ipsec_connections.oci-ipsec-connections]
}

# -----------------------------------------------------------------------------
# Create IPSEC connection management for OCI VCN tunnel b
# -----------------------------------------------------------------------------
resource "oci_core_ipsec_connection_tunnel_management" "oci-ipsec-connection-tunnel-management-b" {
  ipsec_id  = oci_core_ipsec.oci-ipsec-connection.id
  tunnel_id = data.oci_core_ipsec_connection_tunnels.oci-ipsec-connection-tunnels.ip_sec_connection_tunnels[1].id
  routing       = var.routing
  display_name  = var.tunnel_b_display_name

  #Optional
  bgp_session_info {
    customer_bgp_asn      = var.routing == "BGP" ? var.customer_bgp_asn : null
    customer_interface_ip = var.routing == "BGP" ? var.bgp_cust_tunnela_ip : null
    oracle_interface_ip   = var.routing == "BGP" ? var.bgp_oci_tunnela_ip : null
  }

  shared_secret = var.shared_secret
  ike_version   = "V1"

  depends_on = [data.oci_core_ipsec_connections.oci-ipsec-connections]
}

# -----------------------------------------------------------------------------
# TODO Update drg ipsec attachment with route tables for OCI VCN tunnels
# -----------------------------------------------------------------------------
