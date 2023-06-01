locals {

  network_firewall = {
    network_firewall_name        = "OCI-ELZ-NFW-${var.environment_prefix}-HUB"
    network_firewall_policy_name = "OCI-ELZ-NFW-Policy-${var.environment_prefix}"
    ip_address_lists = {
      "vcn-ips" = [var.hub_vcn_cidr_block]
    }
    security_rules = {
      "reject-all-rule" = {
        security_rules_action                 = "REJECT"
        security_rules_condition_applications = []
        security_rules_condition_destinations = []
        security_rules_condition_sources      = []
        security_rules_condition_urls         = []
      }
    }
  }

}

module "network_firewall" {
  source = "../../modules/network-firewall"

  compartment_id               = var.network_compartment_id
  network_firewall_subnet_id   = var.network_firewall_subnet_id
  network_firewall_name        = local.network_firewall.network_firewall_name
  network_firewall_policy_name = local.network_firewall.network_firewall_policy_name
  ip_address_lists             = local.network_firewall.ip_address_lists
  security_rules               = local.network_firewall.security_rules
}
