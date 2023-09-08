locals {
  network_firewall = {
    network_firewall_name        = var.nfw_instance_name != "" ? var.nfw_instance_name : "OCI-ELZ-NFW-${var.environment_prefix}"
    network_firewall_policy_name = var.nfw_instance_policy != "" ? var.nfw_instance_name : "OCI-ELZ-NFW-Policy-${var.environment_prefix}"
    #drg_id                      =  module.hub.drg_id
    nfw_policy_action            = "ALLOW"
  }
  firewall_threat_log = {
    log_display_name    = "OCI-ELZ-NFW-THREAT-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_category = "threatlog"
    log_source_resource = module.network_firewall.firewall_id
    log_source_service  = "ocinetworkfirewall"
    log_source_type     = "OCISERVICE"
  }
  firewall_traffic_log = {
    log_display_name    = "OCI-ELZ-NFW-TRAFFIC-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_category = "trafficlog"
    log_source_resource = module.network_firewall.firewall_id
    log_source_service  = "ocinetworkfirewall"
    log_source_type     = "OCISERVICE"
  }
}

##############################################################################
###########                 CREATE NETWORK FIREWALL                 ##########
##############################################################################

module "network_firewall" {
  count  = var.enable_network_firewall == "true"  ? 1 : 0
  source = "../../modules/network-firewall"

  network_compartment_ocid       = var.network_compartment_ocid
  network_firewall_subnet_id     = var.network_firewall_subnet_id
  network_firewall_name          = local.network_firewall.network_firewall_name
  network_firewall_policy_name   = local.network_firewall.network_firewall_policy_name
  network_firewall_policy_action = local.network_firewall.nfw_policy_action
}

##############################################################################
###########         Create Firewall VCN: Firewall subnet            ##########
##############################################################################


resource "oci_core_subnet" "oci_network_firewall_subnet" {
  #count                     = local.use_existing_network ? 0 : 1
  count                      = var.enable_network_firewall == "true"  ? 1 : 0
  compartment_id             = var.network_compartment_ocid
  vcn_id                     = var.hub_vcn_id
  cidr_block                 = var.nfw_subnet_cidr_block
  display_name               = var.nfw_subnet_display_name
  dns_label                  = var.nfw_subnet_dns_label
  prohibit_public_ip_on_vnic = false
}

##############################################################################
###########     Create Firewall Firewall Threat and Traffic Log     ##########
##############################################################################
module "firewall_threat_log" {
  count                      = var.enable_network_firewall == "true"  ? 1 : 0
  source = "../../modules/service-log"

  log_display_name    = local.firewall_threat_log.log_display_name
  log_type            = local.firewall_threat_log.log_type
  log_group_id        = module.default_log_group.log_group_id
  log_source_category = local.firewall_threat_log.log_source_category
  log_source_resource = local.firewall_threat_log.log_source_resource
  log_source_service  = local.firewall_threat_log.log_source_service
  log_source_type     = local.firewall_threat_log.log_source_type

  depends_on = [ module.network_firewall, module.default_log_group ]
}

module "firewall_traffic_log" {
  count                      = var.enable_network_firewall == "true"  ? 1 : 0
  source = "../../modules/service-log"

  log_display_name    = local.firewall_traffic_log.log_display_name
  log_type            = local.firewall_traffic_log.log_type
  log_group_id        = module.default_log_group.log_group_id
  log_source_category = local.firewall_traffic_log.log_source_category
  log_source_resource = local.firewall_traffic_log.log_source_resource
  log_source_service  = local.firewall_traffic_log.log_source_service
  log_source_type     = local.firewall_traffic_log.log_source_type

  depends_on = [ module.network_firewall, module.default_log_group ]
}
