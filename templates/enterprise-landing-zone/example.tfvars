##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# Provider
#current_user_ocid    = "## YOUR USER OCID ##"
#region               = "## OCI REGION TO DEPLOY TO"
#tenancy_ocid         = "## YOUR TENANCY OCID ##"
#api_fingerprint      = "## YOUR OCI API KEY FINGERPRINT ##"
#api_private_key_path = "## YOUR OCI API PRIVATE KEY FILE ##"

# iam
resource_label             = "DEMO"
prod_domain_admin_email    = "an-example-email-address@oracle.com"
nonprod_domain_admin_email = "an-example-email-address@oracle.com"
enable_compartment_delete  = false
is_nonprod_env_deploy      = true

# security
enable_cloud_guard                           = true
nonprod_enable_bastion                       = true
prod_enable_bastion                          = true
prod_bastion_client_cidr_block_allow_list    = ["10.0.0.0/16", "10.0.0.0/24"]
nonprod_bastion_client_cidr_block_allow_list = ["10.0.0.0/16", "10.0.0.0/24"]

# budget
nonprod_enable_budget                = true
prod_enable_budget                   = true
nonprod_budget_alert_rule_message    = "test"
nonprod_budget_alert_rule_recipients = "an-example-email-address@oracle.com"
nonprod_budget_alert_rule_threshold  = 1000000
nonprod_budget_amount                = 10000000
prod_budget_alert_rule_message       = "test"
prod_budget_alert_rule_recipients    = "an-example-email-address@oracle.com"
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
prod_hub_public_subnet_dns_label   = "ppublabel"
prod_hub_private_subnet_dns_label  = "prilabel"

prod_spoke_vcn_cidr              = "10.2.0.0/16"
prod_spoke_subnet_web_cidr_block = "10.2.1.0/24"
prod_spoke_subnet_app_cidr_block = "10.2.2.0/24"
prod_spoke_subnet_db_cidr_block  = "10.2.3.0/24"
prod_subnet_app_dns_label        = "papplabel"
prod_subnet_db_dns_label         = "pdblabel"
prod_subnet_web_dns_label        = "pweblabel"

nonprod_hub_vcn_cidr_block            = "10.3.0.0/16"
nonprod_hub_public_subnet_cidr_block  = "10.3.1.0/24"
nonprod_hub_private_subnet_cidr_block = "10.3.2.0/24"
nonprod_hub_public_subnet_dns_label   = "npublabel"
nonprod_hub_private_subnet_dns_label  = "nprilabel"

nonprod_spoke_vcn_cidr              = "10.4.0.0/16"
nonprod_spoke_subnet_web_cidr_block = "10.4.1.0/24"
nonprod_spoke_subnet_app_cidr_block = "10.4.2.0/24"
nonprod_spoke_subnet_db_cidr_block  = "10.4.3.0/24"
nonprod_subnet_app_dns_label        = "napplabel"
nonprod_subnet_db_dns_label         = "ndblabel"
nonprod_subnet_web_dns_label        = "nweblabel"

# Tagging
prod_enable_tagging          = true
nonprod_enable_tagging       = true
nonprod_cost_center_tagging  = "n_cost_tag"
nonprod_geo_location_tagging = "n_geo_tag"
prod_cost_center_tagging     = "p_cost_tag"
prod_geo_location_tagging    = "p_geo_tag"


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

# Logging
onboard_log_analytics = false

# Workload Expansion
prod_additional_workload_subnets_cidr_blocks    = []
nonprod_additional_workload_subnets_cidr_blocks = []
prod_workload_compartment_names                 = []
nonprod_workload_compartment_names              = []

#Network Firewall can be only deployed in Prod or Non_prod Enviornment

enable_network_firewall_prod    = true
enable_traffic_threat_log_prod  = true
nfw_subnet_type_prod            = "public"
nfw_instance_name_prod          = "nfw_name"
nfw_instance_policy_prod        = "nfw_policy_name"
enable_network_firewall_nonprod = "false"

####################################### Access Governance ###################################################
prod_enable_access_governance    = false
admin_domain_name                = "Default"
admin_domain_compartment_ocid    = ""

# ACCESS GOVERNANCE SERVICE INSTANCE DETAILS
prod_ag_license_type               = "Access Governance for Oracle Cloud Infrastructure"
#prod_service_instance_display_name = "prod-access-governance-instance"
prod_service_instance_description  = "Prod OAG service instance"

# ACCESS GOVERNANCE USER COMMON DETAILS
prod_use_existing_agcs_user    = false

# ACCESS GOVERNANCE EXISTING_USER
#prod_agcs_user_private_key_path          = ""
#prod_agcs_user_ocid_oci_system           = ""
#prod_agcs_user_fingerprint_oci_system    = ""

# NEW AG USER
prod_agcs_user_group_display_name = "prod_agcs_group"
prod_agcs_user_name               = "prod_agcs_user"
prod_agcs_user_email              = "prod_something@example.com"

# OCI Connected System
prod_oci_system_name        = "Prod Cloud Gateway"
prod_oci_system_description = "Prod OCI System"
