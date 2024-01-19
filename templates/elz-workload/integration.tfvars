##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

#####################################################
# Workload Expansion Compartment Variable
#####################################################
enable_compartment_delete  				= false
workload_compartment_name               = "ELZ-Workload1-P"
workload_expansion_flag                 = true
environment_prefix                      = "P"
workload_prefix                         = "TestWE"
is_create_alarms                  = false
enable_network_monitoring_alarms  = true
enable_security_monitoring_alarms = true
enable_workload_monitoring_alarms = true
#####################################################
# Workload Expansion Network Variables
#####################################################
workload_spoke_vcn_cidr                          = "10.5.0.0/16"
workload_private_spoke_subnet_web_cidr_block     = "10.5.1.0/24"
workload_private_spoke_subnet_app_cidr_block     = "10.5.2.0/24"
workload_private_spoke_subnet_db_cidr_block      = "10.5.3.0/24"
enable_internet_gateway_spoke                    = false
enable_nat_gateway_spoke                         = true
enable_service_gateway_spoke                     = true

#####################################################
# Workload Expansion: IAM Policy  Variable
#####################################################
workload_admin_group_name    = "TestWE-ADMIN"
application_admin_group_name = "TestWE-APP"
database_admin_group_name    = "TestWE-DB"
security_admin_group_name    = "OCI-ELZ-UGP-P-SEC-ADMIN"
network_admin_group_name     = "OCI-ELZ-UGP-P-NET-ADMIN"

#####################################################

