######################################################################
#     Workload | Workload Expansion Spoke Network Configuration      #
######################################################################
locals {
  workload_nat_gw_spoke_check     = var.enable_nat_gateway_spoke == true ? var.nat_gw_spoke_check : []
  workload_service_gw_spoke_check = var.service_gw_spoke_check

  ipsec_connection_static_routes = var.enable_vpn_or_fastconnect == "VPN" && var.enable_vpn_on_environment ? var.ipsec_connection_static_routes : []
  customer_onprem_ip_cidr        = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? var.customer_onprem_ip_cidr : []

  security_list_display_name_ssh  = "${var.security_list_display_name}-SSH"
  security_list_display_name_ons  = "${var.security_list_display_name}-ONS"
  security_list_display_name_sql  = "${var.security_list_display_name}-SQL"
  security_list_display_name_icmp = "${var.security_list_display_name}-ICMP"
  security_list_display_name_vcn  = "${var.security_list_display_name}-VCN"

  spoke_route_rules_options = {
    route_rules_default = {
      "hub-public-subnet" = {
        network_entity_id = var.drg_id
        destination       = var.hub_public_subnet_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "hub-private-subnet" = {
        network_entity_id = var.drg_id
        destination       = var.hub_private_subnet_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "spoke-route-target" = {
        network_entity_id = var.drg_id
        destination       = var.workload_spoke_vcn_cidr
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_nat_spoke = {
      for index, route in local.workload_nat_gw_spoke_check : "nat-gw-rule-${index}" => {
        network_entity_id = module.workload-spoke-nat-gateway[0].nat_gw_id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_srvc_gw_spoke = {
      for index, route in local.workload_service_gw_spoke_check : "service-gw-rule-${index}" => {
        network_entity_id = module.workload-spoke-service-gateway.service_gw_id
        destination       = data.oci_core_services.service_gateway.services[0]["cidr_block"]
        destination_type  = "SERVICE_CIDR_BLOCK"

      }
    }
    route_rules_vpn = {
      for index, route in local.ipsec_connection_static_routes : "cpe-rule-${index}" => {
        network_entity_id = var.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_fastconnect = {
      for index, route in local.customer_onprem_ip_cidr : "fc-rule-${index}" => {
        network_entity_id = var.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
  }

  spoke_route_rules = {
    route_rules = merge(local.spoke_route_rules_options.route_rules_default,
      local.spoke_route_rules_options.route_rules_nat_spoke,
      local.spoke_route_rules_options.route_rules_srvc_gw_spoke,
      local.spoke_route_rules_options.route_rules_fastconnect,
    local.spoke_route_rules_options.route_rules_vpn)
  }

  workload_expansion_subnet_map = {
    Workload-Spoke-LB-Subnet = {
      name                       = var.workload_private_spoke_subnet_lb_display_name
      description                = "LB Subnet"
      dns_label                  = var.workload_private_spoke_subnet_lb_dns_label
      cidr_block                 = var.workload_private_spoke_subnet_lb_cidr_block
      prohibit_public_ip_on_vnic = true
    }
    Workload-Spoke-App-Subnet = {
      name                       = var.workload_private_spoke_subnet_app_display_name
      description                = "App Subnet"
      dns_label                  = var.workload_private_spoke_subnet_app_dns_label
      cidr_block                 = var.workload_private_spoke_subnet_app_cidr_block
      prohibit_public_ip_on_vnic = true
    }
    Workload-Spoke-Client-Subnet = {
      name                       = var.workload_private_spoke_subnet_client_display_name
      description                = "Client Subnet"
      dns_label                  = var.workload_private_spoke_subnet_client_dns_label
      cidr_block                 = var.workload_private_spoke_subnet_client_cidr_block
      prohibit_public_ip_on_vnic = true
    }
    Workload-Spoke-Backup-Subnet = {
      name                       = var.workload_private_spoke_subnet_backup_display_name
      description                = "Backup Subnet"
      dns_label                  = var.workload_private_spoke_subnet_backup_dns_label
      cidr_block                 = var.workload_private_spoke_subnet_backup_cidr_block
      prohibit_public_ip_on_vnic = true
    }
  }

  ip_protocols = {
    ICMP   = "1"
    TCP    = "6"
    UDP    = "17"
    ICMPv6 = "58"
  }

  security_list_ingress_common_ssh = {
    protocol         = local.ip_protocols.TCP
    source           = var.hub_private_subnet_cidr_block
    description      = "SSH Traffic from Hub"
    source_type      = "CIDR_BLOCK"
    destination_port = 22
  }
  security_list_ingress_common_icmp = {
    protocol    = local.ip_protocols.ICMP
    source      = var.hub_private_subnet_cidr_block
    description = "All ICMP Taffic from Hub"
    source_type = "CIDR_BLOCK"
    icmp_type   = 3
    icmp_code   = 4
  }
  security_list_ingress_common_vcn = {
    protocol    = local.ip_protocols.ICMP
    source      = var.hub_vcn_cidr_block
    description = "VCN ICMP Traffic"
    source_type = "CIDR_BLOCK"
    icmp_type   = 3
  }
  security_list_egress_common = {
    destination      = "0.0.0.0/0"
    protocol         = "all"
    description      = "All egress Traffic"
    destination_type = "CIDR_BLOCK"
  }

  security_list_ingress_client_ons = {
    count            = var.enable_fan_events ? 1 : 0
    protocol         = local.ip_protocols.TCP
    source           = var.workload_private_spoke_subnet_client_cidr_block
    description      = "ONS to FAN events"
    source_type      = "CIDR_BLOCK"
    destination_port = 6200
  }
  security_list_ingress_client_sql = {
    protocol         = local.ip_protocols.TCP
    source           = var.workload_private_spoke_subnet_client_cidr_block
    description      = "SQL Traffic"
    source_type      = "CIDR_BLOCK"
    destination_port = var.db_port
  }
  security_list_egress_client = {
    destination      = "0.0.0.0/0"
    protocol         = "all"
    description      = "All Traffic For All Port"
    destination_type = "CIDR_BLOCK"
    destination_port = 22
  }

}
#Get Service Gateway For Region .
data "oci_core_services" "service_gateway" {
  filter {
    name   = "name"
    values = [".*Object.*Storage"]
    regex  = true
  }
}

######################################################################
#                  Create Workload VCN Spoke                         #
######################################################################
module "workload_spoke_vcn" {
  source = "../../modules/vcn"

  vcn_cidrs           = [var.workload_spoke_vcn_cidr]
  compartment_ocid_id = var.workload_compartment_id
  vcn_display_name    = var.vcn_display_name
  vcn_dns_label       = var.vcn_dns_label
  enable_ipv6         = false

  providers = {
    oci = oci.home_region
  }
}
######################################################################
#          Create Workload VCN Spoke Security List                   #
######################################################################

module "workload_spoke_security_list_ssh" {
  source = "../../modules/security-list"

  compartment_id                        = var.workload_compartment_id
  vcn_id                                = module.workload_spoke_vcn.vcn_id
  spoke_security_list_display_name      = local.security_list_display_name_ssh
  security_list_egress_destination      = local.security_list_egress_common.destination
  security_list_egress_protocol         = local.security_list_egress_common.protocol
  security_list_egress_description      = local.security_list_egress_common.description
  security_list_egress_destination_type = local.security_list_egress_common.destination_type

  security_list_ingress_protocol         = local.security_list_ingress_common_ssh.protocol
  security_list_ingress_source           = local.security_list_ingress_common_ssh.source
  security_list_ingress_description      = local.security_list_ingress_common_ssh.description
  security_list_ingress_source_type      = local.security_list_ingress_common_ssh.source_type
  tcp_options_destination_port_range_min = local.security_list_ingress_common_ssh.destination_port
}
module "workload_spoke_security_list_icmp" {
  source = "../../modules/security-list"

  compartment_id                        = var.workload_compartment_id
  vcn_id                                = module.workload_spoke_vcn.vcn_id
  spoke_security_list_display_name      = local.security_list_display_name_icmp
  security_list_egress_destination      = local.security_list_egress_common.destination
  security_list_egress_protocol         = local.security_list_egress_common.protocol
  security_list_egress_description      = local.security_list_egress_common.description
  security_list_egress_destination_type = local.security_list_egress_common.destination_type

  security_list_ingress_protocol    = local.security_list_ingress_common_icmp.protocol
  security_list_ingress_source      = local.security_list_ingress_common_icmp.source
  security_list_ingress_description = local.security_list_ingress_common_icmp.description
  security_list_ingress_source_type = local.security_list_ingress_common_icmp.source_type
  icmp_options_type                 = local.security_list_ingress_common_icmp.icmp_type
  icmp_options_code                 = local.security_list_ingress_common_icmp.icmp_code
}
module "workload_spoke_security_list_vcn" {
  source = "../../modules/security-list"

  compartment_id                        = var.workload_compartment_id
  vcn_id                                = module.workload_spoke_vcn.vcn_id
  spoke_security_list_display_name      = local.security_list_display_name_vcn
  security_list_egress_destination      = local.security_list_egress_common.destination
  security_list_egress_protocol         = local.security_list_egress_common.protocol
  security_list_egress_description      = local.security_list_egress_common.description
  security_list_egress_destination_type = local.security_list_egress_common.destination_type

  security_list_ingress_protocol    = local.security_list_ingress_common_vcn.protocol
  security_list_ingress_source      = local.security_list_ingress_common_vcn.source
  security_list_ingress_description = local.security_list_ingress_common_vcn.description
  security_list_ingress_source_type = local.security_list_ingress_common_vcn.source_type
  icmp_options_type                 = local.security_list_ingress_common_icmp.icmp_type
}

module "workload_spoke_security_list_ons" {
  source = "../../modules/security-list"
  count  = var.enable_fan_events ? 1 : 0

  compartment_id                        = var.workload_compartment_id
  vcn_id                                = module.workload_spoke_vcn.vcn_id
  spoke_security_list_display_name      = local.security_list_display_name_ons
  security_list_egress_destination      = local.security_list_egress_client.destination
  security_list_egress_protocol         = local.security_list_egress_client.protocol
  security_list_egress_description      = local.security_list_egress_client.description
  security_list_egress_destination_type = local.security_list_egress_client.destination_type

  security_list_ingress_protocol         = local.security_list_ingress_client_ons.protocol
  security_list_ingress_source           = local.security_list_ingress_client_ons.source
  security_list_ingress_description      = local.security_list_ingress_client_ons.description
  security_list_ingress_source_type      = local.security_list_ingress_client_ons.source_type
  tcp_options_destination_port_range_min = local.security_list_ingress_client_ons.destination_port
}
module "workload_spoke_security_list_sql" {
  source = "../../modules/security-list"

  compartment_id                        = var.workload_compartment_id
  vcn_id                                = module.workload_spoke_vcn.vcn_id
  spoke_security_list_display_name      = local.security_list_display_name_sql
  security_list_egress_destination      = local.security_list_egress_client.destination
  security_list_egress_protocol         = local.security_list_egress_client.protocol
  security_list_egress_description      = local.security_list_egress_client.description
  security_list_egress_destination_type = local.security_list_egress_client.destination_type

  security_list_ingress_protocol         = local.security_list_ingress_client_sql.protocol
  security_list_ingress_source           = local.security_list_ingress_client_sql.source
  security_list_ingress_description      = local.security_list_ingress_client_sql.description
  security_list_ingress_source_type      = local.security_list_ingress_client_sql.source_type
  tcp_options_destination_port_range_min = local.security_list_ingress_client_sql.destination_port
}
######################################################################
#          Create Workload VCN Spoke Subnet                          #
######################################################################
module "workload_spoke_subnet" {
  source = "../../modules/subnet"

  subnet_map            = local.workload_expansion_subnet_map
  compartment_id        = var.workload_compartment_id
  vcn_id                = module.workload_spoke_vcn.vcn_id
  subnet_route_table_id = module.workload_spoke_route_table.route_table_id
  subnet_security_list_id = toset(concat([
    module.workload_spoke_security_list_icmp.security_list_id,
    module.workload_spoke_security_list_ssh.security_list_id,
    module.workload_spoke_security_list_vcn.security_list_id,
    module.workload_spoke_security_list_sql.security_list_id,
    ],
    var.enable_fan_events ? [module.workload_spoke_security_list_ons[0].security_list_id] : []
  ))
}

######################################################################
#          Create Workload VCN Spoke Gateway                         #
######################################################################
module "workload-spoke-nat-gateway" {
  source                   = "../../modules/nat-gateway"
  count                    = var.enable_nat_gateway_spoke ? 1 : 0
  nat_gateway_display_name = var.nat_gateway_display_name
  network_compartment_id   = var.workload_compartment_id
  vcn_id                   = module.workload_spoke_vcn.vcn_id
}

module "workload-spoke-service-gateway" {
  source                       = "../../modules/service-gateway"
  network_compartment_id       = var.workload_compartment_id
  service_gateway_display_name = var.service_gateway_display_name
  vcn_id                       = module.workload_spoke_vcn.vcn_id
}
######################################################################
#          Create Workload VCN Spoke Route Table                     #
######################################################################
module "workload_spoke_route_table" {
  source                   = "../../modules/route-table"
  compartment_id           = var.workload_compartment_id
  vcn_id                   = module.workload_spoke_vcn.vcn_id
  route_table_display_name = var.route_table_display_name
  route_rules              = local.spoke_route_rules.route_rules
}
######################################################################
#          Attach Workload Spoke VCN to DRG                          #
######################################################################
module "workload_spoke_vcn_drg_attachment" {
  source                        = "../../modules/drg-attachment"
  drg_id                        = var.drg_id
  vcn_id                        = module.workload_spoke_vcn.vcn_id
  drg_attachment_type           = "VCN"
  drg_attachment_vcn_route_type = "VCN_CIDRS"
}
