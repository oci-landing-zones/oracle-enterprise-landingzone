##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

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
