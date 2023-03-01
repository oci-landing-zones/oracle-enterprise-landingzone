data "oci_core_cpe_device_shapes" "cpe_device_shapes" {
}

data "oci_core_cpe_device_shape" "oci-ipsec-cpe-device-shape" {
  cpe_device_shape_id = data.oci_core_cpe_device_shapes.cpe_device_shapes.cpe_device_shapes[var.cpe_vendor].cpe_device_shape_id
}

data "oci_core_ipsec_connections" "oci-ipsec-connections" {
  compartment_id = var.compartment_ocid
  cpe_id = oci_core_cpe.oci-ipsec-cpe.id
}

data "oci_core_ipsec_connection_tunnels" "oci-ipsec-connection-tunnels" {
  ipsec_id = oci_core_ipsec.oci-ipsec-connection.id
}

data "oci_core_ipsec_connection_tunnel" "oci-ipsec-connection-tunnel-a" {
  ipsec_id  = oci_core_ipsec.oci-ipsec-connection.id
  tunnel_id = data.oci_core_ipsec_connection_tunnels.oci-ipsec-connection-tunnels.ip_sec_connection_tunnels[0].id
}

data "oci_core_ipsec_connection_tunnel" "oci-ipsec-connection-tunnel-b" {
  ipsec_id  = oci_core_ipsec.oci-ipsec-connection.id
  tunnel_id = data.oci_core_ipsec_connection_tunnels.oci-ipsec-connection-tunnels.ip_sec_connection_tunnels[1].id
}
