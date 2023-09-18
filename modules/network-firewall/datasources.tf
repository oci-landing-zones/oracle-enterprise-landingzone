data "oci_core_private_ips" "firewall_subnet_private_ip" {
  subnet_id = var.network_firewall_subnet_id
  depends_on = [
    time_sleep.network_firewall_ip_delay
  ]
  
  filter {
    name   = "display_name"
    values = [var.network_firewall_name]
  }
}
