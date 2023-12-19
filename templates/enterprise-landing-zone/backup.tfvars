##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

#current_user_ocid    = 
#region               = 
#tenancy_ocid         = 
#api_fingerprint      = 
#api_private_key_path = 

# Backup Region
backup_region                   = "<region_name>"
enable_landing_zone_replication = true
backup_prod_workload_cidr = "10.6.0.0/16"
backup_nonprod_workload_cidr = "10.7.0.0/16"

# iam
resource_label             = "Resource_Label"
prod_domain_admin_email    = "<user_name>@<domain_name>.com"
nonprod_domain_admin_email = "<user_name>@<domain_name>.com"
enable_compartment_delete  = false

# security
enable_cloud_guard                           = true
cloud_guard_target_tenancy                   = false
nonprod_enable_bastion                       = false
prod_enable_bastion                          = false
prod_bastion_client_cidr_block_allow_list    = ["10.0.0.0/16", "10.0.0.0/24"]
nonprod_bastion_client_cidr_block_allow_list = ["10.0.0.0/16", "10.0.0.0/24"]

# budget
nonprod_enable_budget                = false
prod_enable_budget                   = false
nonprod_budget_alert_rule_message    = "test"
nonprod_budget_alert_rule_recipients = "<user_name>@<domain_name>.com"
nonprod_budget_alert_rule_threshold  = 1000000
nonprod_budget_amount                = 10000000
prod_budget_alert_rule_message       = "test"
prod_budget_alert_rule_recipients    = "<user_name>@<domain_name>.com"
prod_budget_alert_rule_threshold     = 1000000
prod_budget_amount                   = 10000000

# network extension
enable_vpn_or_fastconnect           = "NONE"
prod_enable_vpn                     = true
prod_cpe_ip_address                 = "10.0.0.0"
prod_cpe_display_name               = "OCI-ELZ-CPE-P-HUB-001"
prod_cpe_vendor                     = 4
prod_ipsec_connection_static_routes = ["10.0.0.0/16", "11.0.0.0/16"]
nonprod_enable_vpn                  = false

# network
prod_enable_internet_gateway_hub  = "true"
prod_enable_nat_gateway_hub       = "true"
prod_enable_service_gateway_hub   = "true"
prod_enable_nat_gateway_spoke     = "true"
prod_enable_service_gateway_spoke = "true"

nonprod_enable_internet_gateway_hub  = "true"
nonprod_enable_nat_gateway_hub       = "true"
nonprod_enable_service_gateway_hub   = "true"
nonprod_enable_nat_gateway_spoke     = "true"
nonprod_enable_service_gateway_spoke = "true"

prod_hub_vcn_cidr_block            = "10.1.0.0/16"
prod_hub_public_subnet_cidr_block  = "10.1.1.0/24"
prod_hub_private_subnet_cidr_block = "10.1.2.0/24"

prod_spoke_vcn_cidr              = "10.2.0.0/16"
prod_spoke_subnet_web_cidr_block = "10.2.1.0/24"
prod_spoke_subnet_app_cidr_block = "10.2.2.0/24"
prod_spoke_subnet_db_cidr_block  = "10.2.3.0/24"

nonprod_hub_vcn_cidr_block            = "10.3.0.0/16"
nonprod_hub_public_subnet_cidr_block  = "10.3.1.0/24"
nonprod_hub_private_subnet_cidr_block = "10.3.2.0/24"

nonprod_spoke_vcn_cidr              = "10.4.0.0/16"
nonprod_spoke_subnet_web_cidr_block = "10.4.1.0/24"
nonprod_spoke_subnet_app_cidr_block = "10.4.2.0/24"
nonprod_spoke_subnet_db_cidr_block  = "10.4.3.0/24"

# Tagging
prod_enable_tagging          = false
nonprod_enable_tagging       = false
nonprod_cost_center_tagging  = "n_cost_tag"
nonprod_geo_location_tagging = "n_geo_tag"
prod_cost_center_tagging     = "p_cost_tag"
prod_geo_location_tagging    = "p_geo_tag"

# Log Analytics
onboard_log_analytics = false

# Monitoring (Optional)
prod_network_topic_endpoints     = []
prod_secops_topic_endpoints      = []
prod_platform_topic_endpoints    = []
prod_identity_topic_endpoints    = []
prod_workload_topic_endpoints    = []
nonprod_network_topic_endpoints  = []
nonprod_secops_topic_endpoints   = []
nonprod_platform_topic_endpoints = []
nonprod_identity_topic_endpoints = []
nonprod_workload_topic_endpoints = []

# Workload Expansion
prod_additional_workload_subnets_cidr_blocks    = []
nonprod_additional_workload_subnets_cidr_blocks = []
prod_workload_compartment_names                 = []
nonprod_workload_compartment_names              = []

#Network Firewall
enable_network_firewall_prod   = false
enable_traffic_threat_log_prod = false
nfw_subnet_type_prod           = "public"
nfw_instance_name_prod         = "nfw_p"
nfw_instance_policy_prod       = "nfw_policy_p"

is_create_alarms = false

backup_enable_vpn_or_fastconnect           = "NONE"
backup_prod_enable_vpn                     = true
backup_prod_cpe_ip_address                 = "10.0.0.0"
backup_prod_cpe_display_name               = "OCI-ELZ-CPE-P-HUB-001"
backup_prod_cpe_vendor                     = 4
backup_prod_ipsec_connection_static_routes = ["10.0.0.0/16", "11.0.0.0/16"]
backup_nonprod_enable_vpn                  = false
