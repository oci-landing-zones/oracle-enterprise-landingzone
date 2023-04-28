#tfvars file for the ci pipline

#Tenancy Related Variables

#current_user_ocid    = ""
#region               = ""
#tenancy_ocid         = ""
#api_fingerprint      = ""
#api_private_key_path = ""

# iam
resource_label             					 = "LIVELAB"
enable_compartment_delete  					 = false
prod_domain_admin_email                      = ""
# security
enable_cloud_guard                           = false
cloud_guard_target_tenancy                   = false
is_service_connector_limit                   = true
prod_enable_bastion                          = true
prod_bastion_client_cidr_block_allow_list    = ["0.0.0.0/0"]


# budget
prod_budget_alert_rule_message       	     = "LIVELAB_BUDGET"
prod_budget_alert_rule_threshold     		 = 1000000
prod_budget_amount                   		 = 10000000
prod_enable_budget                   		 = true

#monitoring
is_create_alarms                             = false

#Identity 
domain_license_type                          = "free"

# network extension
prod_enable_vpn                              = false

# Network

prod_enable_internet_gateway_hub             = "true"    
prod_enable_nat_gateway_hub                  = "true"
prod_enable_service_gateway_hub              = "true"
prod_enable_nat_gateway_spoke                = "true"
prod_enable_service_gateway_spoke            = "true"

prod_hub_vcn_cidr_block             	     = "10.1.0.0/16"
prod_hub_public_subnet_cidr_block  		     = "10.1.1.0/24"
prod_hub_private_subnet_cidr_block 			 = "10.1.2.0/24"

prod_spoke_vcn_cidr              			 = "10.2.0.0/16"
prod_spoke_subnet_web_cidr_block 			 = "10.2.1.0/24"
prod_spoke_subnet_app_cidr_block 			 = "10.2.2.0/24"
prod_spoke_subnet_db_cidr_block  			 = "10.2.3.0/24"

#tagging
prod_cost_center_tagging     = "LIVELAB_COST_TAG"
prod_geo_location_tagging    = "LIVELAB_GEO_TAG"
prod_enable_tagging          = true

# logging
onboard_log_analytics = false
