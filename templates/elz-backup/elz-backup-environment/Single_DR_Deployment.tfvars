##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

#Provide Current User OCID
current_user_ocid    = 
#Region Name
region               = 
#Tenanacy OCID
tenancy_ocid         = 
# API Key Fingerprint
api_fingerprint      = 
# API Private Key Path
api_private_key_path = 


# Backup Region
backup_region                   = ""
resource_label                  = ""
environment_prefix              = ""

# Provide Compartment Name and OCID

environment_compartment_id = ""
home_compartment_name      = ""
home_compartment_id        = ""
security_compartment_id    = ""
network_compartment_id     = ""
workload_compartment_id    = ""
logging_compartment_id     = ""


# Monitoring 

network_topic_endpoints   = []
secops_topic_endpoints    = []
platform_topic_endpoints  = []
identity_topic_endpoints  = []
workload_topic_endpoints  = []

is_create_alarms                   = false
enable_security_monitoring_alarms  = false
enable_network_monitoring_alarms   = false
enable_workload_monitoring_alarms  = false

# Network

enable_internet_gateway_hub             = "true"
enable_nat_gateway_hub                  = "true"
enable_service_gateway_hub              = "true"
vcn_cidr_block                          = ""
public_subnet_cidr_block                = ""
private_subnet_cidr_block               = ""
private_spoke_subnet_web_cidr_block     = ""
private_spoke_subnet_app_cidr_block     = ""
private_spoke_subnet_db_cidr_block      = ""
spoke_vcn_cidr                          = ""
enable_nat_gateway_spoke                = true
enable_service_gateway_spoke            = true

enable_network_firewall         = false
enable_traffic_threat_log       = false
nfw_subnet_type                 = "public"
nfw_instance_name               = "nfw_name"
nfw_instance_policy             = "nfw_policy_name"

# Network Extension
enable_vpn_or_fastconnect      = "NONE"
enable_vpn_on_environment      = true
cpe_ip_address                 = "10.0.0.0"
cpe_display_name               = "OCI-ELZ-CPE-P-HUB-001"
cpe_vendor                     = 4
ipsec_connection_static_routes = ["10.0.0.0/16", "11.0.0.0/16"]
remote_peering_connection_peer_id   = ""
region_key                          = ""

#Security
bastion_client_cidr_block_allow_list    = ["10.0.0.0/16", "10.0.0.0/24"]