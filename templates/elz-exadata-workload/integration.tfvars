##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# Provider
current_user_ocid    = ""
region               = ""
tenancy_ocid         = ""
api_fingerprint      = ""
api_private_key_path = "~/.ssh/oci_api_key.pem"

resource_label             = ""
environment_prefix         = ""
environment_compartment_id = ""

workload_name      = ""
workload_prefix    = ""
db_port            = 1522
fan_events_enabled = true

# workload_compartment_name                    = ""
# workload_admin_group_name                    = ""
# application_admin_group_name                 = ""
# exadata_infra_admin_group_name               = ""
# database_admin_group_name                    = ""
# network_admin_group_name                     = ""
# security_compartment_name                    = ""

security_compartment_id = ""
identity_domain_id      = ""

#identity_domain_name                         = ""

# vcn_dns_label                               = ""
# vcn_display_name                            = ""

workload_spoke_vcn_cidr                         = ""
workload_private_spoke_subnet_lb_cidr_block     = ""
workload_private_spoke_subnet_app_cidr_block    = ""
workload_private_spoke_subnet_client_cidr_block = ""
workload_private_spoke_subnet_backup_cidr_block = ""
enable_nat_gateway_spoke                        = true

# nat_gw_spoke_check                            = [""]
# service_gw_spoke_check                        = [""]
# nat_gateway_display_name                    = ""
# service_gateway_display_name                = ""
# route_table_display_name                    = ""
# security_list_display_name                  = ""
# workload_private_spoke_subnet_lb_display_name = ""
# workload_private_spoke_subnet_app_display_name = ""
# workload_private_spoke_subnet_client_display_name = ""
# workload_private_spoke_subnet_backup_display_name = ""
# workload_private_spoke_subnet_lb_dns_label = ""
# workload_private_spoke_subnet_app_dns_label = ""
# workload_private_spoke_subnet_client_dns_label = ""
# workload_private_spoke_subnet_backup_dns_label = ""

drg_id                        = ""
hub_public_subnet_cidr_block  = ""
hub_private_subnet_cidr_block = ""

# customer_onprem_ip_cidr   = ""

enable_vpn_on_environment = false
enable_vpn_or_fastconnect = false

# ipsec_connection_static_routes    = ""

enable_bastion                       = true
bastion_client_cidr_block_allow_list = []

default_log_group_id = ""

is_create_alarms                  = false
enable_workload_monitoring_alarms = false

# workload_topic_endpoints  = []
