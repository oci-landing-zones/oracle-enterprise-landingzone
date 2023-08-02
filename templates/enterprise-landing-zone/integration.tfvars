#tfvars file for the ci pipline


# iam
resource_label             = "INTEGRATION"
enable_compartment_delete  = false
is_baseline_deploy         = true

# security
enable_cloud_guard                           = true
cloud_guard_target_tenancy                   = false
nonprod_enable_bastion                       = true
prod_enable_bastion                          = true
prod_bastion_client_cidr_block_allow_list    = ["0.0.0.0/0"]
nonprod_bastion_client_cidr_block_allow_list = ["0.0.0.0/0"]

# budget
nonprod_budget_alert_rule_message    = "test"
nonprod_budget_alert_rule_threshold  = 1000000
nonprod_budget_amount                = 10000000
prod_budget_alert_rule_message       = "test"
prod_budget_alert_rule_threshold     = 1000000
prod_budget_amount                   = 10000000
nonprod_enable_budget                = true
prod_enable_budget                   = true

# network extension
enable_vpn_or_fastconnect = "VPN"
prod_enable_vpn           = true
prod_cpe_ip_address       = "129.146.57.36"
prod_cpe_display_name     = "OCI-ELZ-CPE-P-HUB-001"
prod_cpe_vendor           = 4
prod_ipsec_connection_static_routes = ["172.16.0.0/16"]
nonprod_enable_vpn        = false

# Network

prod_enable_internet_gateway_hub                 = "true"
prod_enable_nat_gateway_hub                      = "true"
prod_enable_service_gateway_hub                  = "true"
prod_enable_nat_gateway_spoke                    = "true"
prod_enable_service_gateway_spoke                = "true"

nonprod_enable_internet_gateway_hub              = "true"
nonprod_enable_nat_gateway_hub                   = "true"
nonprod_enable_service_gateway_hub               = "true"
nonprod_enable_nat_gateway_spoke                 = "true"
nonprod_enable_service_gateway_spoke             = "true"

prod_hub_vcn_cidr_block             			= "10.1.0.0/16"
prod_hub_public_subnet_cidr_block  				= "10.1.1.0/24"
prod_hub_private_subnet_cidr_block 				= "10.1.2.0/24"

prod_spoke_vcn_cidr              				= "10.2.0.0/16"
prod_spoke_subnet_web_cidr_block 				= "10.2.1.0/24"
prod_spoke_subnet_app_cidr_block 				= "10.2.2.0/24"
prod_spoke_subnet_db_cidr_block  				= "10.2.3.0/24"

nonprod_hub_vcn_cidr_block             			= "10.3.0.0/16"
nonprod_hub_public_subnet_cidr_block  			= "10.3.1.0/24"
nonprod_hub_private_subnet_cidr_block 			= "10.3.2.0/24"

nonprod_spoke_vcn_cidr              			= "10.4.0.0/16"
nonprod_spoke_subnet_web_cidr_block 			= "10.4.1.0/24"
nonprod_spoke_subnet_app_cidr_block 			= "10.4.2.0/24"
nonprod_spoke_subnet_db_cidr_block  			= "10.4.3.0/24"

#tagging
nonprod_cost_center_tagging  = "n_cost_tag"
nonprod_geo_location_tagging = "n_geo_tag"
prod_cost_center_tagging     = "p_cost_tag"
prod_geo_location_tagging    = "p_geo_tag"
prod_enable_tagging          = true
nonprod_enable_tagging       = true

# logging
onboard_log_analytics = false

#Workload

workload_name_prefix = "Workload1"

# Workload Expansion
# prod_additional_workload_subnets_cidr_blocks = []
# nonprod_additional_workload_subnets_cidr_blocks = []