##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# Provider

current_user_ocid    = ""
region               = ""
tenancy_ocid         = ""
api_fingerprint      = ""
api_private_key_path = ""

#####################################################
# Workload Expansion Compartment Variable
#####################################################
enable_compartment_delete  				= false
workload_compartment_name               = ""
environment_compartment_id              = ""
workload_expansion_flag                 = true
environment_prefix                      = "N"
workload_prefix                         = "WRK1"

#####################################################
# Workload Expansion IAM Group Variable
#####################################################
identity_domain_id           = ""
identity_domain_name         = ""
security_compartment_name    = ""
security_compartment_id      = ""
workload_admin_group_name    = ""
application_admin_group_name = ""
database_admin_group_name    = ""
idcs_endpoint                = ""


#####################################################
# Workload Expansion Network Variables 
#####################################################
vcn_display_name                                 = ""
vcn_dns_label                                    = ""
workload_spoke_vcn_cidr                          = "10.5.0.0/16"
workload_private_spoke_subnet_web_cidr_block     = "10.5.1.0/24"
workload_private_spoke_subnet_app_cidr_block     = "10.5.2.0/24"
workload_private_spoke_subnet_db_cidr_block      = "10.5.3.0/24"
enable_nat_gateway_spoke                         = true
enable_service_gateway_spoke                     = true
drg_id                                           = ""
hub_public_subnet_cidr_block                     = "10.1.1.0/24"
hub_private_subnet_cidr_block                    = "10.1.2.0/24"
workload_private_spoke_subnet_web_dns_label      = "wrkweblabel"
workload_private_spoke_subnet_app_dns_label      = "wrkapplabel"
workload_private_spoke_subnet_db_dns_label       = "wrkdblabel"
nat_gateway_display_name = ""
service_gateway_display_name = ""
workload_private_spoke_subnet_web_display_name = ""
workload_private_spoke_subnet_app_display_name = ""
workload_private_spoke_subnet_db_display_name = ""
route_table_display_name = ""
security_list_display_name = ""


#####################################################
# Workload Expansion Monitoring Variables
#####################################################
workload_topic_endpoints = [""]
workload_name            = "W"
enable_network_monitoring_alarms  = false
enable_security_monitoring_alarms = false
enable_workload_monitoring_alarms = false

#####################################################
# Workload Expansion Security Variables
#####################################################
enable_bastion                       = true
bastion_client_cidr_block_allow_list = ["10.0.0.0/16", "10.0.0.0/24"]


# Workload Expansion
#baseline_spoke_subnets_cidr_blocks = []
