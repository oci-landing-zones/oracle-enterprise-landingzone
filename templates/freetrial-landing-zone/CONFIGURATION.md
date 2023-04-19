## Oracle Enterprise Landing Zone Configuration Guide

This configuration guide will detail the required and available configurations needed to deploy an Oracle Enterprise Landing Zone (OELZ) on Oracle Cloud Infrastructure. 

## Prerequisites

The Oracle Enterprise Landing Zone is designed to be deployed to a tenancy owned by the individual Tenancy Administrator. The user deploying the OELZ must be a member of the Administrators group for the tenancy.  The tenancy must have the required Resource Limits and have the Logging Analytics feature turned on.  Detailed information on these prerequisites, and how to check that your tenancy meets them, and enable needed features can be found in the [Implementation Document](Implementation.md)


## Minimum Required Configuration

Deployment of the OELZ is controlled by several Terraform [input variables](README.md#inputs), however most of these have sensible default values. Here are the minimum required configurations to deploy a OELZ:

### Basic Terraform Connection Information
The required provider variables for the OELZ:

| Name                                                                                                 | Description                                                  | Type     | Default | Required |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ | -------- | ------- | :------: |
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid)            | The ID of user to deploy the OELZ.                   | `string` | `""`    |    no    |
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint)                    | The API fingerprint which can be retrieved from the console. | `string` | `""`    |    no    |
| <a name="input_api_private_key"></a> [api\_private\_key](#input\_api\_private\_key)                  | The API private key                                          | `string` | `""`    |    no    |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key                        | `string` | `""`    |    no    |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid)                             | The ID of tenancy                                            | `string` | n/a     |   yes    |
| <a name="input_region"></a> [region](#input\_region)                                                 | The OCI region to deploy the OELZ resources to.      | `string` | n/a     |   yes    |


### OELZ Stack variables

| Variable                               | Value                                   | 
| :------------------------------------- | --------------------------------------- | 
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label)  | "LIVELAB"    |
| <a name="enable_compartment_delete"></a> [enable\_compartment\_delete](#enable\_compartment\_delete) | false   |
| <a name="prod_domain_admin_email"></a> [prod\_domain\_admin\_email](#prod\_domain\_admin\_email) | Enter Email Address   |
| <a name="home_compartment_name"></a> [home_compartment_name](#home_compartment_name) | "LIVELAB-OCI-CMP-HOME"   |
| <a name="enable_cloud_guard"></a> [enable\_cloud\_guard](#enable\_cloud\_guard) | false   |
| <a name="cloud_guard_target_tenancy"></a> [cloud\_guard\_target\_tenancy](#cloud\_guard\_target\_tenancy) | false   |
| <a name="prod_enable_bastion"></a> [prod\_enable\_bastion](#prod\_enable\_bastion) | true   |
| <a name="prod_bastion_client_cidr_block_allow_list"></a> [prod\_bastion\_client\_cidr\_block\_allow\_list](#prod\_bastion\_client\_cidr\_block\_allow\_list) | "10.0.0.0/16" "10.0.0.0/24"   |
| <a name="prod_budget_alert_rule_message"></a> [prod\_budget\_alert\_rule\_message](#prod\_budget\_alert\_rule\_message) | "LIVELAB_ALEART"   |
| <a name="prod_budget_alert_rule_threshold"></a> [prod\_budget\_alert\_rule\_threshold](#prod\_budget\_alert\_rule\_threshold) | "10000000"   |
| <a name="prod_budget_amount"></a> [prod\_budget\_amount](#prod\_budget\_amount) | "1000000"   |
| <a name="prod_enable_budget"></a> [prod\_enable\_budget](#prod\_enable\_budget) | true   |
| <a name="is_create_alarms"></a> [is\_create\_alarms](#is\_create\_alarms) | false   |
| <a name="domain_license_type"></a> [domain\_license\_type](#domain\_license\_type) | "free"   |
| <a name="onboard_log_analytics"></a> [onboard\_log\_analytics](#onboard\_log\_analytics) | false   |
| <a name="prod_enable_vpn"></a> [prod\_enable\_vpn](#prod\_enable\_vpn) | false   |
| <a name="prod_cost_center_tagging"></a> [prod\_cost\_center\_tagging](#prod\_cost\_center\_tagging) | "LIVELAB_COST_TAG"   |
| <a name="prod_geo_location_tagging"></a> [prod\_geo\_location\_tagging](#prod\_geo\_location\_tagging) | "LIVELAB_GEO_TAG"   |
| <a name="prod_enable_tagging"></a> [prod\_enable\_tagging](#prod\_enable\_tagging) | true   |
| <a name="prod_enable_internet_gateway_hub"></a> [prod\_enable\_internet\_gateway\_hub](#prod\_enable\_internet\_gateway\_hub) | true   |
| <a name="prod_enable_nat_gateway_hub"></a> [prod\_enable\_nat\_gateway\_hub](#prod\_enable\_nat\_gateway\_hub) | true   |
| <a name="prod_enable_service_gateway_hub"></a> [prod\_enable\_service\_gateway\_hub](#prod\_enable\_service\_gateway\_hub) | true   |
| <a name="prod_enable_nat_gateway_spoke"></a> [prod\_enable\_nat\_gateway\_spoke](#prod\_enable\_nat\_gateway\_spoke]) | true   |
| <a name="prod_enable_service_gateway_spoke"></a> [prod\_enable\_service\_gateway\_spoke](#prod\_enable\_service\_gateway\_spoke) | true   |
| <a name="prod_hub_vcn_cidr_block"></a> [prod\_hub\_vcn\_cidr\_block](#prod\_hub\_vcn\_cidr\_block) | "10.1.0.0/16"   |
| <a name="prod_hub_public_subnet_cidr_block"></a> [prod\_hub\_public\_subnet\_cidr\_block](#prod\_hub\_public\_subnet\_cidr\_block) | "10.1.1.0/24"   |
| <a name="prod_hub_private_subnet_cidr_block"></a> [prod\_hub\_private\_subnet\_cidr\_block](#prod\_hub\_private\_subnet\_cidr\_block) | "10.1.2.0/24"    |
| <a name="prod_spoke_vcn_cidr"></a> [prod\_spoke\_vcn\_cidr](#prod\_spoke\_vcn\_cidr) | "10.2.0.0/16"   |
| <a name="prod_spoke_subnet_web_cidr_block"></a> [prod\_spoke\_subnet\_web\_cidr\_block](#prod\_spoke\_subnet\_web\_cidr\_block) | "10.2.1.0/24"   |
| <a name="prod_spoke_subnet_app_cidr_block"></a> [prod\_spoke\_subnet\_app\_cidr\_block](#prod\_spoke\_subnet\_app\_cidr\_block) | "10.2.2.0/24"   |
| <a name="prod_spoke_subnet_db_cidr_block"></a> [prod\_spoke\_subnet\_db\_cidr\_block](#prod\_spoke\_subnet\_db\_cidr\_block) | "10.2.3.0/24"   |