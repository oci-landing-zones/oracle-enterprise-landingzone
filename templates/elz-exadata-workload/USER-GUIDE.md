<!-- BEGIN_TF_DOCS -->
## Introduction

This is a workload expansion template to deploy Exadata workload on top of Enterprise Landing Zone (ELZ). This template uses *elz-exadata=spoke* template in addition to other base templates.

## Pre-requisites

The below information has to be captured out of Enterprise Landing Zone setup to provision Exadata workload expansion template in the right environment.


| Name | Description |
|------|---------|
| resource_label | Capture the same value used during ELZ setup |
| environment_prefix | The prefix of the environment where Exadata template is deployed |
| environment_compartment_id | The OCID of the environment where Exadata template is deployed |
| identity_domain_id | The OCID of the Environment specific Identity Domain |
| network_compartment_id | The OCID of the network compartment of the required environment |
| security_compartment_id | The OCID of the security compartment of the required environment |
| drg_id | The OCID of the DRG of the required environment |
| hub_vcn_id | The OCID of the Hub Network VCN of the required environment |
| hub_vcn_cidr_block | The CIDR block range of Hub VCN of the required environment |
| hub_public_subnet_cidr_block | The CIDR block range of Public Subnet in the Hub VCN of the required environment |
| hub_private_subnet_cidr_block | The CIDR block range of Private Subnet in the Hub VCN of the required environment |
| default_log_group_id | The OCID of the defaullt log group of the required environment |

In addition to the above ELZ specific parameters, the values for the below workload specific parameters to be captured.

| Name | Description |
|------|---------|
| workload_name | The name of the workload, preferably 5-7 characters |
| workload_prefix | The short form of the workload, preferably 2-3 characters |
| db_port | Mention the custom DB port. The default is 1521 |
| enable_fan_events | True or False. To create the security list to open port 6200 |
| enable_datasafe | True or False. *True* will create the required IAM groups and Policies for Data Safe |
| enable_bastion | True or False |
| bastion_client_cidr_block_allow_list | An array of CIDR ranges to whitelist for Bastion Service |
| workload_spoke_vcn_cidr | The CIDR range for Spoke VCN |
| workload_private_spoke_subnet_lb_cidr_block | The CIDR range for Spoke VCN Loadbalancer Subnet |
| workload_private_spoke_subnet_app_cidr_block | The CIDR range for Spoke VCN Application Subnet |
| workload_private_spoke_subnet_client_cidr_block | The CIDR range for Spoke VCN Client Subnet |
| workload_private_spoke_subnet_backup_cidr_block | The CIDR range for Spoke VCN Backup Subnet |
| enable_nat_gateway_spoke | True or False |
| vcn_dns_label | The DNS label for Spoke VCN. Default is *spokelabel* |
| workload_private_spoke_subnet_lb_dns_label | The DNS label for Spoke VCN Loadbalancer Subnet. Default is *lbdnslabel* |
| workload_private_spoke_subnet_app_dns_label | The DNS label for Spoke VCN App Subnet. Default is *appdnslabel* |
| workload_private_spoke_subnet_client_dns_label | The DNS label for Spoke VCN Client Subnet. Default is *clientdnslabel* |
| workload_private_spoke_subnet_backup_dns_label | The DNS label for Spoke VCN Backup Subnet. Default is *backupdnslabel* |
| workload_topic_endpoints | An array of Email IDs to be notified for the Workload Topics created |
| enable_workload_monitoring_alarms | True or False |

The below parameters are required to be substituted in case the values were customized during the setup of ELZ. Otherwise, default values are calculated dynamically.

*environment_compartment_name*

*workload_admin_group_name*

*application_admin_group_name*

*exadata_infra_admin_group_name*

*database_admin_group_name*

*datasafe_reports_group_name*

*datasafe_admin_group_name*

*network_admin_group_name*

*security_compartment_name*

The below are few of the optional parameters that can be used to customize the Exadata workload installation further. Make use of those parameters as per the requirement.

*nat_gw_spoke_check*

*service_gw_spoke_check*

*nat_gateway_display_name*

*service_gateway_display_name*

*route_table_display_name*

*security_list_display_name*

*workload_private_spoke_subnet_lb_display_name*

*workload_private_spoke_subnet_app_display_name*

*workload_private_spoke_subnet_client_display_name*

workload_private_spoke_subnet_backup_display_name*

## Installation

By substituting the above parameters, one can chose the option of running the template in Oracle Resource Manager or in a local terminal.

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.