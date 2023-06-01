# Reference
# https://github.com/oracle-quickstart/oci-network-firewall/tree/master/oci-network-firewall-reference-architecture
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "time_sleep" "network_firewall_ip_delay" {
  depends_on = [oci_network_firewall_network_firewall.network_firewall]
  create_duration = "90s"
}

resource "oci_network_firewall_network_firewall" "network_firewall" {
  compartment_id             = var.compartment_id
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  subnet_id                  = var.network_firewall_subnet_id
  display_name               = var.network_firewall_name
}

resource "oci_network_firewall_network_firewall_policy" "network_firewall_policy" {
  display_name   = var.network_firewall_policy_name
  compartment_id = var.compartment_id

  dynamic "ip_address_lists" {
    for_each = var.ip_address_lists
    content {
      ip_address_list_name  = ip_address_lists.key
      ip_address_list_value = ip_address_lists.value
    }
  }

  dynamic "security_rules" {
    for_each = var.security_rules
    content {
      name   = security_rules.key
      action = security_rules.value.security_rules_action
      # inspection = security_rules.value.security_rules_inspection

      condition {
        applications = security_rules.value.security_rules_condition_applications
        destinations = security_rules.value.security_rules_condition_destinations
        sources      = security_rules.value.security_rules_condition_sources
        urls         = security_rules.value.security_rules_condition_urls
      }
    }
  }

}
