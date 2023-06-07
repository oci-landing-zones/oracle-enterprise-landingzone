locals {
  vcn_hub_network = {
    name = "OCI-ELZ-VCN-${var.environment_prefix}-HUB-${local.region_key[0]}"
  }
  internet_gateway = {
    internet_gateway_display_name = "OCI-ELZ-IGW-${var.environment_prefix}-HUB"
  }
  nat_gateway = {
    nat_gateway_display_name = "OCI-ELZ-NGW-${var.environment_prefix}-HUB"
  }

  ipsec_connection_static_routes = var.enable_vpn_or_fastconnect == "VPN" && var.enable_vpn_on_environment ? var.ipsec_connection_static_routes : []
  customer_onprem_ip_cidr        = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? var.customer_onprem_ip_cidr : []

  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks != [] ? var.additional_workload_subnets_cidr_blocks : []

  igw_hub_check                  = var.enable_internet_gateway_hub ? var.igw_hub_check : []
  nat_gw_hub_check               = var.enable_nat_gateway_hub ? var.nat_gw_hub_check : []
  service_gw_hub_check           = var.enable_service_gateway_hub ? var.service_gw_hub_check : []

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
    route_rules              = merge(local.hub_public_route_rules_options.route_rules_default, local.hub_public_route_rules_options.route_rules_igw, local.hub_public_route_rules_options.route_rules_vpn, local.hub_public_route_rules_options.route_rules_fastconnect, local.hub_public_route_rules_options.route_rules_workload)
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
    route_rules              = merge(local.hub_private_route_rules_options.route_rules_default,local.hub_private_route_rules_options.route_rules_nat,local.hub_private_route_rules_options.route_rules_srvc_gw, local.hub_private_route_rules_options.route_rules_vpn, local.hub_private_route_rules_options.route_rules_fastconnect, local.hub_private_route_rules_options.route_rules_workload)
  }

  list_info = {
    hub_display_name   = "OCI-ELZ-${var.environment_prefix}-Hub-Security-List"
  }

  ip_protocols = {
    ICMP   = "1"
    TCP    = "6"
    UDP    = "17"
    ICMPv6 = "58"
  }
  security_list_ingress_open = {
    protocol         = "all"
    source           = "0.0.0.0/0"
    description      = "All Traffic For All Port"
    source_type      = "CIDR_BLOCK"
  }
  security_list_ingress_icmp = {
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
  security_list_ingress = var.enable_network_firewall ? local.security_list_ingress_open  : local.security_list_ingress_icmp

  security_list_egress = {
    destination      = "0.0.0.0/0"
    protocol         = "all"
    description      = "All Traffic For All Port"
    destination_type = "CIDR_BLOCK"
  }


  hub_internet_gateway = {
    vcn_id                        = oci_core_vcn.vcn_hub_network.id
    internet_gateway_display_name = "OCI-ELZ-IGW-${var.environment_prefix}-HUB"
  }
  hub_nat_gateway = {
    vcn_id                   = oci_core_vcn.vcn_hub_network.id
    nat_gateway_display_name = "OCI-ELZ-NGW-${var.environment_prefix}-HUB"
  }
  service_gateway_hub = {
    service_gateway_display_name = "OCI-ELZ-SGW-${var.environment_prefix}-HUB"
    vcn_id                       = oci_core_vcn.vcn_hub_network.id
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

resource "oci_core_vcn" "vcn_hub_network" {
  cidr_blocks    = [var.vcn_cidr_block]
  compartment_id = var.network_compartment_id
  display_name   = local.vcn_hub_network.name
  dns_label      = "hublabel"
  is_ipv6enabled = false
}

locals {
  nfw_dest = var.enable_network_firewall ? module.network-firewall[0].firewall_ip: null
  hub_ingress_route_rules_options = {
    route_rules_default = var.enable_network_firewall ? {
      "ingress-web-traffic" = {
        network_entity_id = local.nfw_dest
        destination       = var.private_spoke_subnet_web_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "ingress-app-traffic" = {
        network_entity_id = local.nfw_dest
        destination       = var.private_spoke_subnet_app_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "ingress-db-traffic" = {
        network_entity_id = local.nfw_dest
        destination       = var.private_spoke_subnet_db_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
    } : {}
    route_rules_workload = var.enable_network_firewall ? {
      for index, route in local.additional_workload_subnets_cidr_blocks : "workload-ingress-rule-${index}" => {
        network_entity_id = local.nfw_dest
        destination       = route
        destination_type  = "CIDR_BLOCK"
      }
    } : {}
  }

  hub_ingress_route_rules = {
    route_table_display_name = "OCI-ELZ-RTING-${var.environment_prefix}-HUB"
    route_rules              = merge(local.hub_ingress_route_rules_options.route_rules_default,
                                     local.hub_ingress_route_rules_options.route_rules_workload)
  }
}

resource "oci_core_route_table" "hub_ingress_route_table" {
  count = var.enable_network_firewall ? 1 : 0
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.vcn_hub_network.id
  display_name   = local.hub_ingress_route_rules.route_table_display_name
  dynamic "route_rules" {
    for_each = local.hub_ingress_route_rules.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}

resource "oci_core_default_security_list" "hub_default_security_list_locked_down" {
  manage_default_resource_id = oci_core_vcn.vcn_hub_network.default_security_list_id
}

resource "oci_core_security_list" "security_list_hub" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.vcn_hub_network.id
  display_name   = local.list_info.hub_display_name

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

resource "oci_core_subnet" "hub_private_subnet" {
  cidr_block                 = var.private_subnet_cidr_block
  display_name               = "OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}002"
  dns_label                  = "prisublabel"
  compartment_id             = var.network_compartment_id
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vcn_hub_network.id
  route_table_id             = oci_core_route_table.hub_private_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_hub.id])
}

resource "oci_core_route_table" "hub_private_route_table" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.vcn_hub_network.id
  display_name   = local.hub_private_route_rules.route_table_display_name
  dynamic "route_rules" {
    for_each = local.hub_private_route_rules.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}

#Public Subnet and route table
resource "oci_core_subnet" "hub_public_subnet" {
  cidr_block                 = var.public_subnet_cidr_block
  display_name               = "OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}001"
  dns_label                  = "pubsublabel"
  compartment_id             = var.network_compartment_id
  prohibit_public_ip_on_vnic = false
  vcn_id                     = oci_core_vcn.vcn_hub_network.id
  route_table_id             = oci_core_route_table.hub_public_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_hub.id])
}

resource "oci_core_route_table" "hub_public_route_table" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.vcn_hub_network.id
  display_name   = local.hub_public_route_rules.route_table_display_name
  dynamic "route_rules" {
    for_each = local.hub_public_route_rules.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}

module "hub_internet_gateway" {
  source = "../../modules/internet-gateway"

  count                         = var.enable_internet_gateway_hub == "true"  ? 1 : 0
  network_compartment_id        = var.network_compartment_id
  vcn_id                        = local.hub_internet_gateway.vcn_id
  internet_gateway_display_name = local.hub_internet_gateway.internet_gateway_display_name
}

module "nat-gateway-hub" {
  source = "../../modules/nat-gateway"

  count                    = var.enable_nat_gateway_hub == "true"  ? 1 : 0
  network_compartment_id   = var.network_compartment_id
  vcn_id                   = local.hub_nat_gateway.vcn_id
  nat_gateway_display_name = local.hub_nat_gateway.nat_gateway_display_name
}

module "service-gateway-hub" {
  source                       = "../../modules/service-gateway"

  count                        = var.enable_service_gateway_hub == "true"  ? 1 : 0
  network_compartment_id       = var.network_compartment_id
  vcn_id                       = local.service_gateway_hub.vcn_id
  service_gateway_display_name = local.service_gateway_hub.service_gateway_display_name
}

// DRG
locals {

  drg_route_table_options = {
    default = {}
    firewall = var.enable_network_firewall ? {
      RT-Hub = {
        display_name            = "RT-Hub"
        route_distribution_name = "Import-Hub"
        rules = {

        }
      }
      RT-Spoke = {
        display_name            = "RT-Spoke"
        route_distribution_name = null
        rules = {
          all_to_drg = {
            destination              = "0.0.0.0/0"
            destination_type         = "CIDR_BLOCK"
            next_hop_attachment_name = "Hub-VCN-Attachment"
          }
        }
      }

    } : {}

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
    firewall = var.enable_network_firewall ? {
      Import-Hub = {
        distribution_display_name = "Import-Hub"
        distribution_type         = "IMPORT"
        statements = {}
      }
    } : {}
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
        display_name         = "Hub-Vcn-Drg-${var.environment_prefix}-Attachment"
        vcn_id               = oci_core_vcn.vcn_hub_network.id
        route_table_id       = var.enable_network_firewall ? oci_core_route_table.hub_ingress_route_table[0].id : null
        drg_route_table_name = var.enable_network_firewall ? "RT-Hub" : null
      }
    }
    drg_route_table_map    = merge(local.drg_route_table_options.default, 
                                   local.drg_route_table_options.virtual_circuit,
                                   local.drg_route_table_options.firewall)
    route_distribution_map = merge(local.drg_route_distribution_options.default,
                                   local.drg_route_distribution_options.virtual_circuit,
                                   local.drg_route_distribution_options.firewall)
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


module "network-firewall" {
  source = "../elz-oci-net-fw"
  count  = var.enable_network_firewall ? 1 : 0 

  tenancy_ocid               = var.tenancy_ocid
  region                     = var.region
  environment_prefix         = var.environment_prefix
  network_compartment_id     = var.network_compartment_id
  hub_vcn_cidr_block         = var.vcn_cidr_block
  network_firewall_subnet_id = oci_core_subnet.hub_private_subnet.id

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

}