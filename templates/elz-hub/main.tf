##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

######################################################################
#                   Create Local Variables                           #
######################################################################
locals {

  ipsec_connection_static_routes = var.enable_vpn_or_fastconnect == "VPN" && var.enable_vpn_on_environment ? var.ipsec_connection_static_routes : []
  customer_onprem_ip_cidr        = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? var.customer_onprem_ip_cidr : []

  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks != [] ? var.additional_workload_subnets_cidr_blocks : []

  igw_hub_check        = var.enable_internet_gateway_hub ? var.igw_hub_check : []
  nat_gw_hub_check     = var.enable_nat_gateway_hub ? var.nat_gw_hub_check : []
  service_gw_hub_check = var.enable_service_gateway_hub ? var.service_gw_hub_check : []

  check_nfw_public_subnet_flag  = var.enable_network_firewall && var.nfw_subnet_type == "public" ? true : false
  check_nfw_private_subnet_flag = var.enable_network_firewall && var.nfw_subnet_type == "private" ? true : false
  nfw_private_forwarding_true   = local.check_nfw_private_subnet_flag && !var.nfw_use_existing_network ? true : false
  nfw_public_forwarding_true    = local.check_nfw_public_subnet_flag && !var.nfw_use_existing_network ? true : false

  #nfw_ip_ocid_value       = var.enable_network_firewall ? data.oci_core_private_ips.firewall_subnet_private_ip.private_ips[*].id : " "
  nfw_ip_ocid_value       = [try(data.oci_core_private_ips.firewall_subnet_private_ip.private_ips[0].id,null), "" ] [var.enable_network_firewall ? 0 : 1]

  hub_public_route_rules_options = {
    route_rules_default = {
      "hub-to-web-traffic" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_spoke_subnet_web_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "hub-to-app-traffic" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_spoke_subnet_app_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "hub-to-db-traffic" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_spoke_subnet_db_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_igw = {
      for index, route in local.igw_hub_check : "igw-rule-${index}" => {
        network_entity_id = module.hub_internet_gateway[0].internet_gw_id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_vpn = {
      for index, route in local.ipsec_connection_static_routes : "cpe-rule-${index}" => {
        network_entity_id = module.drg.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_fastconnect = {
      for index, route in local.customer_onprem_ip_cidr : "fc-rule-${index}" => {
        network_entity_id = module.drg.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_workload = {
      for index, route in local.additional_workload_subnets_cidr_blocks : "workload-rule-${index}" => {
        network_entity_id = module.drg.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
  }

  hub_public_route_rules = {
    route_table_display_name = "OCI-ELZ-RTPUB-${var.environment_prefix}-HUB001"
    route_rules              = merge(local.hub_public_route_rules_options.route_rules_default, local.hub_public_route_rules_options.route_rules_igw,
    local.hub_public_route_rules_options.route_rules_vpn,
    local.hub_public_route_rules_options.route_rules_fastconnect, local.hub_public_route_rules_options.route_rules_workload)
  }

  hub_public_route_rules_options_nfw = {
    route_rules_default = {
      "hub-to-web-traffic" = {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = var.private_spoke_subnet_web_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "hub-to-app-traffic" = {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = var.private_spoke_subnet_app_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "hub-to-db-traffic" = {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = var.private_spoke_subnet_db_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_igw = {
      for index, route in local.igw_hub_check : "igw-rule-${index}" => {
        network_entity_id = module.hub_internet_gateway[0].internet_gw_id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_vpn = {
      for index, route in local.ipsec_connection_static_routes : "cpe-rule-${index}" => {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_fastconnect = {
      for index, route in local.customer_onprem_ip_cidr : "fc-rule-${index}" => {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_workload = {
      for index, route in local.additional_workload_subnets_cidr_blocks : "workload-rule-${index}" => {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
  }

  hub_public_route_rules_nfw = {
    route_table_display_name = "OCI-ELZ-RTPUB-${var.environment_prefix}-HUB001"
    route_rules              = merge(local.hub_public_route_rules_options_nfw.route_rules_default, local.hub_public_route_rules_options_nfw.route_rules_igw,
    local.hub_public_route_rules_options_nfw.route_rules_vpn,
    local.hub_public_route_rules_options_nfw.route_rules_fastconnect,
    local.hub_public_route_rules_options_nfw.route_rules_workload)
  }
  
  hub_public_route_check_test_nfw         = var.enable_network_firewall && var.nfw_subnet_type == "private" ? local.hub_public_route_rules_nfw : local.hub_public_route_rules

  list_info = {
    hub_display_name = "OCI-ELZ-${var.environment_prefix}-Hub-Security-List"
  }

  hub_private_route_rules_options = {
    route_rules_default = {
      "pri-hub-to-web-traffic" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_spoke_subnet_web_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "pri-hub-to-app-traffic" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_spoke_subnet_app_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "pri-hub-to-db-traffic" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_spoke_subnet_db_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_nat = {
      for index, route in local.nat_gw_hub_check : "nat-gw-rule-${index}" => {
        network_entity_id = module.nat-gateway-hub[0].nat_gw_id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_srvc_gw = {
      for index, route in local.service_gw_hub_check : "service-gw-rule-${index}" => {
        network_entity_id = module.service-gateway-hub[0].service_gw_id
        destination       = data.oci_core_services.service_gateway.services[0]["cidr_block"]
        destination_type  = "SERVICE_CIDR_BLOCK"
      }
    }
    route_rules_vpn = {
      for index, route in local.ipsec_connection_static_routes : "cpe-rule-${index}" => {
        network_entity_id = module.drg.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_fastconnect = {
      for index, route in local.customer_onprem_ip_cidr : "fc-rule-${index}" => {
        network_entity_id = module.drg.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_workload = {
      for index, route in local.additional_workload_subnets_cidr_blocks : "workload-rule-${index}" => {
        network_entity_id = module.drg.drg_id
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
  }

  hub_private_route_rules = {
    route_table_display_name = "OCI-ELZ-RTPRV-${var.environment_prefix}-HUB002"
    route_rules              = merge(local.hub_private_route_rules_options.route_rules_default, local.hub_private_route_rules_options.route_rules_nat, 
    local.hub_private_route_rules_options.route_rules_srvc_gw, 
    local.hub_private_route_rules_options.route_rules_vpn, 
    local.hub_private_route_rules_options.route_rules_fastconnect, local.hub_private_route_rules_options.route_rules_workload)
  }

  hub_private_route_rules_options_nfw = {
    route_rules_default = {
      "pri-hub-to-web-traffic" = {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = var.private_spoke_subnet_web_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "pri-hub-to-app-traffic" = {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = var.private_spoke_subnet_app_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "pri-hub-to-db-traffic" = {

        network_entity_id = local.nfw_ip_ocid_value
        destination       = var.private_spoke_subnet_db_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_nat = {
      for index, route in local.nat_gw_hub_check : "nat-gw-rule-${index}" => {
        network_entity_id = module.nat-gateway-hub[0].nat_gw_id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_srvc_gw = {
      for index, route in local.service_gw_hub_check : "service-gw-rule-${index}" => {
        network_entity_id = module.service-gateway-hub[0].service_gw_id
        destination       = data.oci_core_services.service_gateway.services[0]["cidr_block"]
        destination_type  = "SERVICE_CIDR_BLOCK"
      }
    }
    route_rules_vpn = {
      for index, route in local.ipsec_connection_static_routes : "cpe-rule-${index}" => {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_fastconnect = {
      for index, route in local.customer_onprem_ip_cidr : "fc-rule-${index}" => {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_workload = {
      for index, route in local.additional_workload_subnets_cidr_blocks : "workload-rule-${index}" => {
        network_entity_id = local.nfw_ip_ocid_value
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    }
  }

  hub_private_route_rules_nfw = {
    route_table_display_name = "OCI-ELZ-RTPRV-${var.environment_prefix}-HUB002"
    route_rules              = merge(local.hub_private_route_rules_options_nfw.route_rules_default, local.hub_private_route_rules_options_nfw.route_rules_nat, local.hub_private_route_rules_options_nfw.route_rules_srvc_gw, local.hub_private_route_rules_options_nfw.route_rules_vpn, local.hub_private_route_rules_options_nfw.route_rules_fastconnect, local.hub_private_route_rules_options_nfw.route_rules_workload)
  }

  hub_private_route_check_test_nfw = var.enable_network_firewall && var.nfw_subnet_type == "public" ? local.hub_private_route_rules_nfw : local.hub_private_route_rules

  ip_protocols = {
    ICMP   = "1"
    TCP    = "6"
    UDP    = "17"
    ICMPv6 = "58"
  }
  security_list_ingress = {
    protocol    = local.ip_protocols.ICMP
    source      = "0.0.0.0/0"
    description = "All ICMP Taffic"
    source_type = "CIDR_BLOCK"
  }
  security_list_ingress_ssh = {
    protocol    = local.ip_protocols.TCP
    source      = "0.0.0.0/0"
    description = "SSH Traffic"
    source_type = "CIDR_BLOCK"
    tcp_port    = 22
  }
  security_list_egress = {
    destination      = "0.0.0.0/0"
    protocol         = "all"
    description      = "All Traffic For All Port"
    destination_type = "CIDR_BLOCK"
  }

  subnet_info_map = {
    hub_private_subnet_map = {
      name                       = var.hub_private_subnet_display_name
      description                = var.hub_private_subnet_description
      dns_label                  = var.hub_private_subnet_dns_label
      cidr_block                 = var.private_subnet_cidr_block
      prohibit_public_ip_on_vnic = true
    }
    hub_public_subnet_map = {
      name                       = var.hub_public_subnet_display_name
      description                = var.hub_public_subnet_description
      dns_label                  = var.hub_public_subnet_dns_label
      cidr_block                 = var.public_subnet_cidr_block
      prohibit_public_ip_on_vnic = true
    }
  }
  hub_private_subnet_map = {
    hub_pri_subnet_map = {
      name                       = var.hub_private_subnet_display_name
      description                = var.hub_private_subnet_description
      dns_label                  = var.hub_private_subnet_dns_label
      cidr_block                 = var.private_subnet_cidr_block
      prohibit_public_ip_on_vnic = true
    }
  }
  hub_public_subnet_map = {
    hub_pub_subnet_map = {
      name                       = var.hub_public_subnet_display_name
      description                = var.hub_public_subnet_description
      dns_label                  = var.hub_public_subnet_dns_label
      cidr_block                 = var.public_subnet_cidr_block
      prohibit_public_ip_on_vnic = true
    }
  }
}
data "oci_core_services" "service_gateway" {
  filter {
    name   = "name"
    values = [".*Object.*Storage"]
    regex  = true
  }
}

data "oci_core_subnets" "subnets" {
  compartment_id = var.network_compartment_id
}
output "nfw_ip_ocid_value" {
      value = local.nfw_ip_ocid_value
}
######################################################################
#                      Create  Hub VCN                               #
######################################################################

resource "oci_core_vcn" "vcn_hub_network" {
  cidr_blocks    = [var.vcn_cidr_block]
  compartment_id = var.network_compartment_id
  display_name   = var.hub_vcn_name
  dns_label      = var.hub_vcn_dns_label
  is_ipv6enabled = false
}

######################################################################
#                   Create Hub VCN Security List                     #
######################################################################

resource "oci_core_default_security_list" "hub_default_security_list_locked_down" {
  manage_default_resource_id = oci_core_vcn.vcn_hub_network.default_security_list_id
}

resource "oci_core_security_list" "security_list_hub" {
  compartment_id  = var.network_compartment_id
  vcn_id          = oci_core_vcn.vcn_hub_network.id
  display_name    = local.list_info.hub_display_name

  egress_security_rules {
    destination      = local.security_list_egress.destination
    protocol         = local.security_list_egress.protocol
    description      = local.security_list_egress.description
    destination_type = local.security_list_egress.destination_type
  }
  ingress_security_rules {
    protocol    = local.security_list_ingress.protocol
    source      = local.security_list_ingress.source
    description = local.security_list_ingress.description
    source_type = local.security_list_ingress.source_type
  }
  dynamic "ingress_security_rules" {
    for_each = var.add_ssh_to_security_list ? [1] : []
    content {
      protocol    = local.security_list_ingress_ssh.protocol
      source      = local.security_list_ingress_ssh.source
      description = local.security_list_ingress_ssh.description
      source_type = local.security_list_ingress_ssh.source_type
      tcp_options {
        max = local.security_list_ingress_ssh.tcp_port
        min = local.security_list_ingress_ssh.tcp_port
      }
    }
  }
}

######################################################################
#       Create Hub Public And Private Subnet and Route Table         #
######################################################################

######################################################################
#                  Create Hub Private Subnet                         #
######################################################################

resource "oci_core_subnet" "hub_private_subnet" {
  cidr_block                 = var.private_subnet_cidr_block
  display_name               = var.hub_private_subnet_display_name
  dns_label                  = var.hub_private_subnet_dns_label
  compartment_id             = var.network_compartment_id
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vcn_hub_network.id
  #route_table_id             = oci_core_route_table.hub_private_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_hub.id])
}

######################################################################
#                 Create Hub Private Route Table                     #
######################################################################

resource "oci_core_route_table" "hub_private_route_table" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.vcn_hub_network.id
  display_name   = local.hub_private_route_rules.route_table_display_name
  dynamic "route_rules" {
    for_each = local.hub_private_route_check_test_nfw.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}

######################################################################
#       Associate Hub Private Route Table to Private Subnet          #
######################################################################

resource "oci_core_route_table_attachment" "private_route_table_attachment" {  
  subnet_id      = oci_core_subnet.hub_private_subnet.id
  route_table_id = oci_core_route_table.hub_private_route_table.id
}

######################################################################
#                   Create Hub Public Subnet                         #
######################################################################

resource "oci_core_subnet" "hub_public_subnet" {
  cidr_block                 = var.public_subnet_cidr_block
  display_name               = var.hub_public_subnet_display_name
  dns_label                  = var.hub_public_subnet_dns_label
  compartment_id             = var.network_compartment_id
  prohibit_public_ip_on_vnic = false
  vcn_id                     = oci_core_vcn.vcn_hub_network.id
  #route_table_id             = oci_core_route_table.hub_public_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_hub.id])
}

######################################################################
#                   Create Hub Public Route Table                    #
######################################################################

resource "oci_core_route_table" "hub_public_route_table" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.vcn_hub_network.id
  display_name   = local.hub_public_route_rules.route_table_display_name
  dynamic "route_rules" {
    for_each = local.hub_public_route_check_test_nfw.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}

######################################################################
#         Associate Hub Public Route Table to Public Subnet          #
######################################################################

resource "oci_core_route_table_attachment" "public_route_table_attachment" {  
  subnet_id      = oci_core_subnet.hub_public_subnet.id
  route_table_id = oci_core_route_table.hub_public_route_table.id
}

######################################################################
#                    Create Hub Internet Gateway                     #
######################################################################

module "hub_internet_gateway" {
  source = "../../modules/internet-gateway"

  count                         = var.enable_internet_gateway_hub == "true" ? 1 : 0
  network_compartment_id        = var.network_compartment_id
  vcn_id                        = oci_core_vcn.vcn_hub_network.id
  internet_gateway_display_name = var.igw_gateway_display_name

}
######################################################################
#                    Create Hub NAT Gateway                          #
######################################################################

module "nat-gateway-hub" {
  source = "../../modules/nat-gateway"

  count                    = var.enable_nat_gateway_hub == "true" ? 1 : 0
  
  network_compartment_id   = var.network_compartment_id
  vcn_id                   = oci_core_vcn.vcn_hub_network.id
  nat_gateway_display_name = var.nat_gateway_display_name

}
######################################################################
#                Create Hub Service Gateway                          #
######################################################################
module "service-gateway-hub" {
  source = "../../modules/service-gateway"

  count                        = var.enable_service_gateway_hub == "true" ? 1 : 0
  
  network_compartment_id       = var.network_compartment_id
  vcn_id                       = oci_core_vcn.vcn_hub_network.id
  service_gateway_display_name = var.srv_gateway_display_name

}


######################################################################
#                          Create Hub DRG                            #
######################################################################
locals {
  drg_route_table_options = {
    default = {}
    virtual_circuit = var.enable_vpn_or_fastconnect == "FASTCONNECT" && var.enable_fastconnect_on_environment ? {
      RT-Onprem = {
        display_name            = "RT-Onprem"
        route_distribution_name = "Import_Onprem"
        rules = {

        }
      }
      RT-RPC = {
        display_name            = "RT-RPC"
        route_distribution_name = "Import_RPC"
        rules = {

        }
      }
    } : {}
  }
  drg_route_distribution_options = {
    default = {}
    virtual_circuit = var.enable_vpn_or_fastconnect == "FASTCONNECT" && var.enable_fastconnect_on_environment ? {
      Import_Onprem = {
        distribution_display_name = "Import_Onprem"
        distribution_type         = "IMPORT"
        statements = {
          "statement-1" = {
            action              = "ACCEPT"
            match_type          = "DRG_ATTACHMENT_TYPE" # DRG_ATTACHMENT_ID DRG_ATTACHMENT_TYPE MATCH_ALL
            attachment_type     = "REMOTE_PEERING_CONNECTION"
            drg_attachment_name = ""
            priority            = 1
          }
          "statement-2" = {
            action              = "ACCEPT"
            match_type          = "DRG_ATTACHMENT_TYPE" # DRG_ATTACHMENT_ID DRG_ATTACHMENT_TYPE MATCH_ALL
            attachment_type     = "VCN"
            drg_attachment_name = ""
            priority            = 2
          }
        }
      }
      Import_RPC = {
        distribution_display_name = "Import_RPC"
        distribution_type         = "IMPORT"
        statements = {
          "statement-3" = {
            action              = "ACCEPT"
            match_type          = "DRG_ATTACHMENT_TYPE" # DRG_ATTACHMENT_ID DRG_ATTACHMENT_TYPE MATCH_ALL
            attachment_type     = "VIRTUAL_CIRCUIT"
            drg_attachment_name = ""
            priority            = 1
          }
        }
      }
    } : {}

  }
  drg = {
    drg_display_name             = "OCI-ELZ-DRG-${var.environment_prefix}-HUB"
    drg_route_table_display_name = "Hub-Vcn-Drg-Route-Table-${var.environment_prefix}"
    drg_vcn_attachments = {
      "Hub-VCN-Attachment" = {
        display_name = "Hub-Vcn-Drg-${var.environment_prefix}-Attachment"
        #vcn_id              = module.vcn_hub_network.vcn_id
        vcn_id               = oci_core_vcn.vcn_hub_network.id
        route_table_id       = ""
        drg_route_table_name = null
      }
    }
    drg_route_table_map    = merge(local.drg_route_table_options.default, local.drg_route_table_options.virtual_circuit)
    route_distribution_map = merge(local.drg_route_distribution_options.default, local.drg_route_distribution_options.virtual_circuit)
  }
}

module "drg" {
  source = "../../modules/drg"

  compartment_id         = var.network_compartment_id
  drg_display_name       = local.drg.drg_display_name
  drg_vcn_attachments    = local.drg.drg_vcn_attachments
  drg_route_table_map    = local.drg.drg_route_table_map
  route_distribution_map = local.drg.route_distribution_map
}


######################################################################
#          Network Firewall Related Variable Defination              #
######################################################################

locals {
  network_firewall_info = {
    network_firewall_name        = var.nfw_instance_name != "" ? var.nfw_instance_name : "OCI-ELZ-NFW-${var.environment_prefix}"
    network_firewall_policy_name = var.nfw_instance_policy != "" ? var.nfw_instance_policy : "OCI-ELZ-NFW-Policy-${var.environment_prefix}"

    nfw_policy_action = "REJECT"

    ip_address_lists = {
      "vcn-ips" = [oci_core_vcn.vcn_hub_network.id]
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
  firewall_threat_log = {
    log_display_name    = "OCI-ELZ-NFW-THREAT-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_category = "threatlog"
    log_source_service  = "ocinetworkfirewall"
    log_source_type     = "OCISERVICE"
  }
  firewall_traffic_log = {
    log_display_name    = "OCI-ELZ-NFW-TRAFFIC-LOG-${var.environment_prefix}"
    log_type            = "SERVICE"
    log_source_category = "trafficlog"
    log_source_service  = "ocinetworkfirewall"
    log_source_type     = "OCISERVICE"
  }
  network_firewall_threat = {
    "Threat_Log" : "oci_network_firewall_network_firewall.network_firewall[*].id"
  }
  network_firewall_traffic = {
    "Traffic_Log" : "oci_network_firewall_network_firewall.network_firewall[*].id"
  }
  #public_subnet_id  = oci_core_subnet.hub_public_subnet[var.hub_public_subnet_display_name].id
  #private_subnet_id = oci_core_subnet.hub_private_subnet[var.hub_private_subnet_display_name].id
  public_subnet_id   = oci_core_subnet.hub_public_subnet.id
  private_subnet_id  = oci_core_subnet.hub_private_subnet.id
  #nfw_subnet_id      = var.nfw_subnet_type == "public" ? local.public_subnet_id : local.private_subnet_id
}

######################################################################
#                      CREATE NETWORK FIREWALL                      #
######################################################################

resource "oci_network_firewall_network_firewall" "network_firewall" {
  count = var.enable_network_firewall ? 1 : 0

  compartment_id             = var.network_compartment_id
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy[0].id
  subnet_id                  = var.nfw_subnet_type == "public" ? local.public_subnet_id : local.private_subnet_id
  display_name               = local.network_firewall_info.network_firewall_name
}

######################################################################
#                   CREATE NETWORK FIREWALL POLICY                   #
######################################################################

resource "oci_network_firewall_network_firewall_policy" "network_firewall_policy" {
  count = var.enable_network_firewall ? 1 : 0

  display_name   = local.network_firewall_info.network_firewall_policy_name
  compartment_id = var.network_compartment_id
  security_rules {
    name   = "reject-all-rule"
    action = "REJECT"
    condition {
      applications = []
      destinations = []
      sources      = []
      urls         = []
    }
  }
}

##############################################################################
###########     Create Firewall Firewall Threat and Traffic Log     ##########
##############################################################################
module "firewall_threat_log" {
  count  = var.enable_network_firewall && var.enable_traffic_threat_log ? 1 : 0
  source = "../../modules/service-log-nfw"

  #service_log_map     = local.network_firewall_threat
  log_display_name    = local.firewall_threat_log.log_display_name
  log_type            = local.firewall_threat_log.log_type
  log_group_id        = var.log_group_id
  log_source_category = local.firewall_threat_log.log_source_category
  log_source_resource = oci_network_firewall_network_firewall.network_firewall[0].id
  log_source_service  = local.firewall_threat_log.log_source_service
  log_source_type     = local.firewall_threat_log.log_source_type
}

module "firewall_traffic_log" {
  count  = var.enable_network_firewall && var.enable_traffic_threat_log ? 1 : 0
  source = "../../modules/service-log-nfw"

  #service_log_map      = local.network_firewall_traffic
  log_display_name     = local.firewall_traffic_log.log_display_name
  log_type             = local.firewall_traffic_log.log_type
  log_group_id         = var.log_group_id
  log_source_category  = local.firewall_traffic_log.log_source_category
  log_source_resource  = oci_network_firewall_network_firewall.network_firewall[0].id
  log_source_service   = local.firewall_traffic_log.log_source_service
  log_source_type      = local.firewall_traffic_log.log_source_type
}