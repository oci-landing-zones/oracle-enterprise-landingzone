##############################################################################
###########                       CREATE VCN                        ##########
##############################################################################
locals {
  vcn_hub_network = {
    name = "OCI-ELZ-VCN-${var.environment_prefix}-HUB-${local.region_key[0]}"
  }
  vcn_internet_gateway = {
    internet_gateway_diplay_name = "OCI-ELZ-IGW-${var.environment_prefix}-HUB"
  }
  internet_gateway = {
    internet_gateway_display_name = "OCI-ELZ-IGW-${var.environment_prefix}-HUB"
  }
  nat_gateway = {
    nat_gateway_display_name = "OCI-ELZ-NGW-${var.environment_prefix}-HUB"
  }
  vcn_spoke = {
    name = "OCI-ELZ-VCN-${var.environment_prefix}-SPK-${local.region_key[0]}001"
  }

  ipsec_connection_static_routes = var.enable_vpn_or_fastconnect == "VPN" && var.enable_vpn_on_environment ? var.ipsec_connection_static_routes : []
  customer_onprem_ip_cidr        = var.enable_vpn_or_fastconnect == "FASTCONNECT" ? var.customer_onprem_ip_cidr : []

  igw_hub_check                  = var.enable_internet_gateway_hub == "true" ? var.igw_hub_check : []
  nat_gw_hub_check               = var.enable_nat_gateway_hub == "true" ? var.nat_gw_hub_check : []
  service_gw_hub_check           = var.enable_service_gateway_hub == "true" ? var.service_gw_hub_check : []
  nat_gw_spoke_check             = var.enable_nat_gateway_spoke == "true" ? var.nat_gw_spoke_check : []
  service_gw_spoke_check         = var.enable_service_gateway_spoke == "true" ? var.service_gw_spoke_check : []

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
  }

  hub_public_route_rules = {
    route_table_display_name = "OCI-ELZ-RTPUB-${var.environment_prefix}-HUB001"
    route_rules              = merge(local.hub_public_route_rules_options.route_rules_default, local.hub_public_route_rules_options.route_rules_igw, local.hub_public_route_rules_options.route_rules_vpn, local.hub_public_route_rules_options.route_rules_fastconnect)
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
  }
  hub_private_route_rules = {
    route_table_display_name = "OCI-ELZ-RTPRV-${var.environment_prefix}-HUB002"
    route_rules              = merge(local.hub_private_route_rules_options.route_rules_default,local.hub_private_route_rules_options.route_rules_nat,local.hub_private_route_rules_options.route_rules_srvc_gw, local.hub_private_route_rules_options.route_rules_vpn, local.hub_private_route_rules_options.route_rules_fastconnect)
  }

  spoke_route_rules_options = {
    route_rules_default = {
      "spoke-public-subnet" = {
        network_entity_id = module.drg.drg_id
        destination       = var.public_subnet_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "spoke-private-subnet" = {
        network_entity_id = module.drg.drg_id
        destination       = var.private_subnet_cidr_block
        destination_type  = "CIDR_BLOCK"
      }
      "spoke-route-target" = {
        network_entity_id = module.drg.drg_id
        destination       = var.spoke_vcn_cidr
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_nat_spoke = {
      for index, route in local.nat_gw_spoke_check : "nat-gw-rule-${index}" => {
        network_entity_id = module.nat-gateway-spoke[0].nat_gw_id
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    }
    route_rules_srvc_gw_spoke = {
      for index, route in local.service_gw_spoke_check : "service-gw-rule-${index}" => {
        network_entity_id = module.service-gateway-spoke[0].service_gw_id
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
  }
  spoke_route_rules = {
    route_table_display_name = "OCI-ELZ-RTPRV-${var.environment_prefix}-SPK001"
    route_rules              = merge(local.spoke_route_rules_options.route_rules_default,local.spoke_route_rules_options.route_rules_nat_spoke,local.spoke_route_rules_options.route_rules_srvc_gw_spoke,local.spoke_route_rules_options.route_rules_vpn, local.spoke_route_rules_options.route_rules_fastconnect)
  }
}
data "oci_core_services" "service_gateway" {
  filter {
    name   = "name"
    values = [".*Object.*Storage"]
    regex  = true
  }
}
##############################################################################
###########                       CREATE HUB                        ##########
##############################################################################
resource "oci_core_vcn" "vcn_hub_network" {
  cidr_blocks    = [var.vcn_cidr_block]
  compartment_id = var.network_compartment_id
  display_name   = local.vcn_hub_network.name
  dns_label      = "hublabel"
  is_ipv6enabled = false
}

resource "oci_core_default_security_list" "hub_default_security_list_locked_down" {
  manage_default_resource_id = oci_core_vcn.vcn_hub_network.default_security_list_id
}

locals {
  list_info = {
    hub_display_name   = "OCI-ELZ-${var.environment_prefix}-Hub-Security-List"
    spoke_display_name = "OCI-ELZ-${var.environment_prefix}-Spk-Security-List"
  }
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
}

#Create the HUB VCN Security Rule 

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

# Private Subnet and route table
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

##############################################################################
###########                   CREATE SPOKE                          ##########
##############################################################################
resource "oci_core_vcn" "vcn_spoke_network" {
  cidr_blocks    = [var.spoke_vcn_cidr]
  compartment_id = var.workload_compartment_id
  display_name   = local.vcn_spoke.name
  dns_label      = "spokelabel"
  is_ipv6enabled = false
}

resource "oci_core_default_security_list" "spoke_default_security_list_locked_down" {
  manage_default_resource_id = oci_core_vcn.vcn_spoke_network.default_security_list_id
}

#Create the HUB VCN Security Rule 
resource "oci_core_security_list" "security_list_spoke" {
  compartment_id = var.workload_compartment_id
  vcn_id         = oci_core_vcn.vcn_spoke_network.id
  display_name   = local.list_info.spoke_display_name

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
}

#Web App and DB Subnet and route table
resource "oci_core_subnet" "spoke_web_subnet" {
  cidr_block                 = var.private_spoke_subnet_web_cidr_block
  display_name               = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}001"
  dns_label                  = "webdnslabel"
  compartment_id             = var.workload_compartment_id
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vcn_spoke_network.id
  route_table_id             = oci_core_route_table.spoke_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_spoke.id])
}
resource "oci_core_subnet" "spoke_app_subnet" {
  cidr_block                 = var.private_spoke_subnet_app_cidr_block
  display_name               = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}002"
  dns_label                  = "appdnslabel"
  compartment_id             = var.workload_compartment_id
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vcn_spoke_network.id
  route_table_id             = oci_core_route_table.spoke_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_spoke.id])
}
resource "oci_core_subnet" "spoke_db_subnet" {
  cidr_block                 = var.private_spoke_subnet_db_cidr_block
  display_name               = "OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}003"
  dns_label                  = "dbdnslabel"
  compartment_id             = var.workload_compartment_id
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vcn_spoke_network.id
  route_table_id             = oci_core_route_table.spoke_route_table.id
  security_list_ids          = toset([oci_core_security_list.security_list_spoke.id])
}

resource "oci_core_route_table" "spoke_route_table" {
  compartment_id = var.workload_compartment_id
  vcn_id         = oci_core_vcn.vcn_spoke_network.id
  display_name   = local.spoke_route_rules.route_table_display_name
  dynamic "route_rules" {
    for_each = local.spoke_route_rules.route_rules
    content {
      description       = route_rules.key
      network_entity_id = route_rules.value.network_entity_id
      destination       = route_rules.value.destination
      destination_type  = route_rules.value.destination_type
    }
  }
}

#TODO Need to format this with the connectivity tests
#TODO Need to add ICMP security allow for tests

data "oci_core_subnets" "subnets" {
  compartment_id = var.network_compartment_id
}
###########################################################################################################
###########            CREATE INTERNET GATEWAY, NAT GATEWAY AND SERVICE GATEWAY                  ##########
###########################################################################################################
locals {
  hub_internet_gateway = {
    vcn_id                        = oci_core_vcn.vcn_hub_network.id
    internet_gateway_display_name = "OCI-ELZ-IGW-${var.environment_prefix}-HUB"
  }
  hub_nat_gateway = {
    vcn_id                   = oci_core_vcn.vcn_hub_network.id
    nat_gateway_display_name = "OCI-ELZ-NGW-${var.environment_prefix}-HUB"
  }

  spoke_nat_gateway = {
    vcn_id                   = oci_core_vcn.vcn_spoke_network.id
    nat_gateway_display_name = "OCI-ELZ-NGW-${var.environment_prefix}-SPK"
  }
  service_gateway_hub = {
    service_gateway_display_name = "OCI-ELZ-SGW-${var.environment_prefix}-HUB"
    vcn_id                       = oci_core_vcn.vcn_hub_network.id
  }
  service_gateway_spoke = {
    service_gateway_display_name = "OCI-ELZ-SGW-${var.environment_prefix}-SPK"
    vcn_id                       = oci_core_vcn.vcn_spoke_network.id
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

module "nat-gateway-spoke" {
  source = "../../modules/nat-gateway"
  
  count                    = var.enable_nat_gateway_spoke == "true"  ? 1 : 0 
  network_compartment_id   = var.workload_compartment_id
  vcn_id                   = local.spoke_nat_gateway.vcn_id
  nat_gateway_display_name = local.spoke_nat_gateway.nat_gateway_display_name
}

module "service-gateway-hub" {
  source                       = "../../modules/service-gateway"
  
  count                        = var.enable_service_gateway_hub == "true"  ? 1 : 0 
  network_compartment_id       = var.network_compartment_id
  vcn_id                       = local.service_gateway_hub.vcn_id
  service_gateway_display_name = local.service_gateway_hub.service_gateway_display_name
}

module "service-gateway-spoke" {
  source                       = "../../modules/service-gateway"
  
  count                        = var.enable_service_gateway_spoke == "true"  ? 1 : 0 
  network_compartment_id       = var.workload_compartment_id
  vcn_id                       = local.service_gateway_spoke.vcn_id
  service_gateway_display_name = local.service_gateway_spoke.service_gateway_display_name
}

##############################################################################################
###########                   CREATE DRG AND DEFAULT POLICY                         ##########
##############################################################################################
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
        display_name         = "Hub-Vcn-Drg-${var.environment_prefix}-Attachment"
        vcn_id               = oci_core_vcn.vcn_hub_network.id
        route_table_id       = ""
        drg_route_table_name = null
      }
      "Spoke-VCN-Attachment" = {
        display_name         = "Workload001-${var.environment_prefix}-VCN-Attachment"
        vcn_id               = oci_core_vcn.vcn_spoke_network.id
        route_table_id       = ""
        drg_route_table_name = null
      }
    }
    drg_route_table_map    = merge(local.drg_route_table_options.default, local.drg_route_table_options.virtual_circuit)
    route_distribution_map = merge(local.drg_route_distribution_options.default, local.drg_route_distribution_options.virtual_circuit)
  }
  group_names = {
    network_admin_group_name : var.network_admin_group_name != "" ? var.network_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-NET-ADMIN",
  }  
  network_default_policy = {
    name        = "OCI-ELZ-${var.environment_prefix}-SRD-NET-DEFAULT-POLICY"
    description = "OCI Network Default Policy"

    statements = [
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage vcns in compartment ${var.network_compartment_name}",
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage drgs in compartment ${var.network_compartment_name}",
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage remote-peering-from in compartment ${var.network_compartment_name}",
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage remote-peering-to in compartment ${var.network_compartment_name}",
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage remote-peering-from in compartment ${var.network_compartment_name}",
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage virtual-network-family in compartment ${var.network_compartment_name}",
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage load-balancers in compartment ${var.network_compartment_name}",
    ]
  }
  workload_default_policy = {
    name        = "OCI-ELZ-${var.environment_prefix}-SRD-NET-WRK-DEFAULT-POLICY"
    description = "OCI Workload Default Policy"

    statements = [
      "Allow group OCI-ELZ-${var.environment_prefix}-IDT/${local.group_names["network_admin_group_name"]} to manage vcns in compartment ${var.workload_compartment_name}",
    ]
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

module "network_default_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.network_compartment_id
  policy_name      = local.network_default_policy.name
  description      = local.network_default_policy.description
  statements       = local.network_default_policy.statements
}
module "workload_default_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.workload_compartment_id
  policy_name      = local.workload_default_policy.name
  description      = local.workload_default_policy.description
  statements       = local.workload_default_policy.statements
}
