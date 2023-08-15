<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_architecture_tag"></a> [architecture\_tag](#module\_architecture\_tag) | ../../modules/tag | n/a |
| <a name="module_budget"></a> [budget](#module\_budget) | ../elz-budget | n/a |
| <a name="module_compartment"></a> [compartment](#module\_compartment) | ../elz-compartment | n/a |
| <a name="module_identity"></a> [identity](#module\_identity) | ../elz-identity | n/a |
| <a name="module_logging"></a> [logging](#module\_logging) | ../elz-logging | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ../elz-monitoring | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../elz-network | n/a |
| <a name="module_network-extension"></a> [network-extension](#module\_network-extension) | ../elz-network-extension | n/a |
| <a name="module_security"></a> [security](#module\_security) | ../elz-security | n/a |
| <a name="module_tagging"></a> [tagging](#module\_tagging) | ../elz-tagging | n/a |
| <a name="module_workload"></a> [workload](#module\_workload) | ../elz-workload | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_workload_subnets_cidr_blocks"></a> [additional\_workload\_subnets\_cidr\_blocks](#input\_additional\_workload\_subnets\_cidr\_blocks) | A list of subnets cidr blocks in additional workload stack | `list(string)` | n/a | yes |
| <a name="input_application_admin_group_name"></a> [application\_admin\_group\_name](#input\_application\_admin\_group\_name) | The group name for the OCI Application Administrators Group | `string` | `""` | no |
| <a name="input_bastion_client_cidr_block_allow_list"></a> [bastion\_client\_cidr\_block\_allow\_list](#input\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. | `list(string)` | n/a | yes |
| <a name="input_bgp_cust_tunnela_ip"></a> [bgp\_cust\_tunnela\_ip](#input\_bgp\_cust\_tunnela\_ip) | n/a | `any` | n/a | yes |
| <a name="input_bgp_md5auth_key"></a> [bgp\_md5auth\_key](#input\_bgp\_md5auth\_key) | n/a | `string` | n/a | yes |
| <a name="input_bgp_oci_tunnela_ip"></a> [bgp\_oci\_tunnela\_ip](#input\_bgp\_oci\_tunnela\_ip) | n/a | `any` | n/a | yes |
| <a name="input_budget_alert_rule_message"></a> [budget\_alert\_rule\_message](#input\_budget\_alert\_rule\_message) | The alert message for budget alerts. | `string` | `""` | no |
| <a name="input_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#input\_budget\_alert\_rule\_recipients) | The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon | `string` | `""` | no |
| <a name="input_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#input\_budget\_alert\_rule\_threshold) | The threshold for the budget alert. | `string` | `""` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | The amount of the budget expressed as a whole number in the currency of the customer's rate card. | `string` | `""` | no |
| <a name="input_cloud_guard_target_tenancy"></a> [cloud\_guard\_target\_tenancy](#input\_cloud\_guard\_target\_tenancy) | true if cloud guard targets to tenancy, false if cloud guard targets to Landing Zone home compartment | `bool` | n/a | yes |
| <a name="input_cost_center_tagging"></a> [cost\_center\_tagging](#input\_cost\_center\_tagging) | Cost Center Varible | `string` | n/a | yes |
| <a name="input_cpe_display_name"></a> [cpe\_display\_name](#input\_cpe\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_cpe_ip_address"></a> [cpe\_ip\_address](#input\_cpe\_ip\_address) | Customer Premises Equipment (CPE) IP address | `string` | n/a | yes |
| <a name="input_cpe_vendor"></a> [cpe\_vendor](#input\_cpe\_vendor) | n/a | `number` | n/a | yes |
| <a name="input_create_master_encryption_key"></a> [create\_master\_encryption\_key](#input\_create\_master\_encryption\_key) | Option create master encryption key | `bool` | n/a | yes |
| <a name="input_customer_bgp_asn"></a> [customer\_bgp\_asn](#input\_customer\_bgp\_asn) | n/a | `any` | n/a | yes |
| <a name="input_customer_onprem_ip_cidr"></a> [customer\_onprem\_ip\_cidr](#input\_customer\_onprem\_ip\_cidr) | n/a | `list(string)` | `[]` | no |
| <a name="input_customer_primary_bgp_peering_ip"></a> [customer\_primary\_bgp\_peering\_ip](#input\_customer\_primary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_customer_secondary_bgp_peering_ip"></a> [customer\_secondary\_bgp\_peering\_ip](#input\_customer\_secondary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_database_admin_group_name"></a> [database\_admin\_group\_name](#input\_database\_admin\_group\_name) | The group name for the OCI Database Logging Administrators Group | `string` | `""` | no |
| <a name="input_domain_admin_email"></a> [domain\_admin\_email](#input\_domain\_admin\_email) | The email address for the identity domain admin. | `string` | n/a | yes |
| <a name="input_domain_license_type"></a> [domain\_license\_type](#input\_domain\_license\_type) | Identity Domain License Type | `string` | n/a | yes |
| <a name="input_enable_bastion"></a> [enable\_bastion](#input\_enable\_bastion) | Option to enable bastion service | `bool` | n/a | yes |
| <a name="input_enable_budget"></a> [enable\_budget](#input\_enable\_budget) | ----------------------------------------------------------------------------- Budget Variables ----------------------------------------------------------------------------- | `bool` | n/a | yes |
| <a name="input_enable_cloud_guard"></a> [enable\_cloud\_guard](#input\_enable\_cloud\_guard) | true if you don't have cloud guard enabled, false if you've already have cloud guard enabled. | `bool` | n/a | yes |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy. | `bool` | `true` | no |
| <a name="input_enable_fastconnect_on_environment"></a> [enable\_fastconnect\_on\_environment](#input\_enable\_fastconnect\_on\_environment) | n/a | `bool` | n/a | yes |
| <a name="input_enable_internet_gateway_hub"></a> [enable\_internet\_gateway\_hub](#input\_enable\_internet\_gateway\_hub) | Option to enable true and Disable false. | `string` | n/a | yes |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Set to true to enable logging compartment which stores the configuration information that landing zones is setting up for the customer. | `bool` | `false` | no |
| <a name="input_enable_nat_gateway_hub"></a> [enable\_nat\_gateway\_hub](#input\_enable\_nat\_gateway\_hub) | Option to enable true and Disable false. | `string` | n/a | yes |
| <a name="input_enable_nat_gateway_spoke"></a> [enable\_nat\_gateway\_spoke](#input\_enable\_nat\_gateway\_spoke) | Option to enable true and Disable false. | `string` | n/a | yes |
| <a name="input_enable_network_monitoring_alarms"></a> [enable\_network\_monitoring\_alarms](#input\_enable\_network\_monitoring\_alarms) | Enable Network Monitoring Alarms in Network Compartment | `bool` | n/a | yes |
| <a name="input_enable_security_monitoring_alarms"></a> [enable\_security\_monitoring\_alarms](#input\_enable\_security\_monitoring\_alarms) | Enable Security Monitoring Alarms in Security Compartment | `bool` | n/a | yes |
| <a name="input_enable_service_gateway_hub"></a> [enable\_service\_gateway\_hub](#input\_enable\_service\_gateway\_hub) | Option to enable true and Disable false. | `string` | n/a | yes |
| <a name="input_enable_service_gateway_spoke"></a> [enable\_service\_gateway\_spoke](#input\_enable\_service\_gateway\_spoke) | Option to enable true and Disable false. | `string` | n/a | yes |
| <a name="input_enable_tagging"></a> [enable\_tagging](#input\_enable\_tagging) | Set to true to enable Tagging. | `bool` | `false` | no |
| <a name="input_enable_tf_state_backup"></a> [enable\_tf\_state\_backup](#input\_enable\_tf\_state\_backup) | Set to true to enable logging compartment which contains the bucket for the log files. | `bool` | `false` | no |
| <a name="input_enable_vault_replication"></a> [enable\_vault\_replication](#input\_enable\_vault\_replication) | Option to enable vault replication | `bool` | n/a | yes |
| <a name="input_enable_vpn_on_environment"></a> [enable\_vpn\_on\_environment](#input\_enable\_vpn\_on\_environment) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT. | `string` | n/a | yes |
| <a name="input_enable_workload_monitoring_alarms"></a> [enable\_workload\_monitoring\_alarms](#input\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Workload Compartment | `bool` | n/a | yes |
| <a name="input_environment_compartment_name"></a> [environment\_compartment\_name](#input\_environment\_compartment\_name) | The name of the compartment that acts as the main compartment for the environment. Resources related to this environment will be created under this compartment. | `string` | `""` | no |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_fastconnect_provider"></a> [fastconnect\_provider](#input\_fastconnect\_provider) | Fastconnect Variables | `string` | n/a | yes |
| <a name="input_fastconnect_routing_policy"></a> [fastconnect\_routing\_policy](#input\_fastconnect\_routing\_policy) | n/a | `list(string)` | n/a | yes |
| <a name="input_geo_location_tagging"></a> [geo\_location\_tagging](#input\_geo\_location\_tagging) | Geo Location. | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_home_compartment_name"></a> [home\_compartment\_name](#input\_home\_compartment\_name) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_iam_admin_group_name"></a> [iam\_admin\_group\_name](#input\_iam\_admin\_group\_name) | The group name for the OCI Landing Zone IAM Administrators Group | `string` | `""` | no |
| <a name="input_identity_topic_endpoints"></a> [identity\_topic\_endpoints](#input\_identity\_topic\_endpoints) | List of email addresses for Identity notifications. | `list(string)` | `[]` | no |
| <a name="input_igw_hub_check"></a> [igw\_hub\_check](#input\_igw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_ipsec_connection_static_routes"></a> [ipsec\_connection\_static\_routes](#input\_ipsec\_connection\_static\_routes) | n/a | `list(string)` | n/a | yes |
| <a name="input_ipsec_display_name"></a> [ipsec\_display\_name](#input\_ipsec\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_is_create_alarms"></a> [is\_create\_alarms](#input\_is\_create\_alarms) | Enable Alarms Creation in all Compartment | `bool` | n/a | yes |
| <a name="input_is_service_connector_limit"></a> [is\_service\_connector\_limit](#input\_is\_service\_connector\_limit) | Restrict Number of Service Connector Deployment | `bool` | n/a | yes |
| <a name="input_nat_gw_hub_check"></a> [nat\_gw\_hub\_check](#input\_nat\_gw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_nat_gw_spoke_check"></a> [nat\_gw\_spoke\_check](#input\_nat\_gw\_spoke\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_network_admin_group_name"></a> [network\_admin\_group\_name](#input\_network\_admin\_group\_name) | The group name for the OCI Landing Zone Network Administrators Group | `string` | `""` | no |
| <a name="input_network_topic_endpoints"></a> [network\_topic\_endpoints](#input\_network\_topic\_endpoints) | List of email addresses for Network Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_ops_admin_group_name"></a> [ops\_admin\_group\_name](#input\_ops\_admin\_group\_name) | The group name for the OCI Landing Zone Ops Administrators Group | `string` | `""` | no |
| <a name="input_oracle_primary_bgp_peering_ip"></a> [oracle\_primary\_bgp\_peering\_ip](#input\_oracle\_primary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_oracle_secondary_bgp_peering_ip"></a> [oracle\_secondary\_bgp\_peering\_ip](#input\_oracle\_secondary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_platform_admin_group_name"></a> [platform\_admin\_group\_name](#input\_platform\_admin\_group\_name) | The group name for the OCI Landing Zone Platform Administrators Group | `string` | `""` | no |
| <a name="input_platform_topic_endpoints"></a> [platform\_topic\_endpoints](#input\_platform\_topic\_endpoints) | List of email addresses for Platform notifications. | `list(string)` | `[]` | no |
| <a name="input_private_spoke_subnet_app_cidr_block"></a> [private\_spoke\_subnet\_app\_cidr\_block](#input\_private\_spoke\_subnet\_app\_cidr\_block) | Spoke App Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_db_cidr_block"></a> [private\_spoke\_subnet\_db\_cidr\_block](#input\_private\_spoke\_subnet\_db\_cidr\_block) | Spoke DB Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_web_cidr_block"></a> [private\_spoke\_subnet\_web\_cidr\_block](#input\_private\_spoke\_subnet\_web\_cidr\_block) | Spoke Web Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_private_subnet_cidr_block"></a> [private\_subnet\_cidr\_block](#input\_private\_subnet\_cidr\_block) | Hub Private Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_provider_service_key_name"></a> [provider\_service\_key\_name](#input\_provider\_service\_key\_name) | n/a | `string` | n/a | yes |
| <a name="input_public_subnet_cidr_block"></a> [public\_subnet\_cidr\_block](#input\_public\_subnet\_cidr\_block) | Hub Public Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_region_key"></a> [region\_key](#input\_region\_key) | n/a | `string` | n/a | yes |
| <a name="input_remote_peering_connection_peer_id"></a> [remote\_peering\_connection\_peer\_id](#input\_remote\_peering\_connection\_peer\_id) | n/a | `string` | `null` | no |
| <a name="input_remote_peering_connection_peer_region_name"></a> [remote\_peering\_connection\_peer\_region\_name](#input\_remote\_peering\_connection\_peer\_region\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label) | Prefix used to avoid naming conflict | `string` | n/a | yes |
| <a name="input_retention_policy_duration_amount"></a> [retention\_policy\_duration\_amount](#input\_retention\_policy\_duration\_amount) | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | n/a | yes |
| <a name="input_retention_policy_duration_time_unit"></a> [retention\_policy\_duration\_time\_unit](#input\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount. | `string` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | n/a | `string` | n/a | yes |
| <a name="input_secops_topic_endpoints"></a> [secops\_topic\_endpoints](#input\_secops\_topic\_endpoints) | List of email addresses for Secops Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_security_admin_group_name"></a> [security\_admin\_group\_name](#input\_security\_admin\_group\_name) | The group name for the OCI Landing Zone Security Administrators Group | `string` | `""` | no |
| <a name="input_service_gw_hub_check"></a> [service\_gw\_hub\_check](#input\_service\_gw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_service_gw_spoke_check"></a> [service\_gw\_spoke\_check](#input\_service\_gw\_spoke\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_shared_secret"></a> [shared\_secret](#input\_shared\_secret) | n/a | `any` | n/a | yes |
| <a name="input_spoke_vcn_cidr"></a> [spoke\_vcn\_cidr](#input\_spoke\_vcn\_cidr) | Spoke VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_tunnel_a_display_name"></a> [tunnel\_a\_display\_name](#input\_tunnel\_a\_display\_name) | n/a | `any` | n/a | yes |
| <a name="input_tunnel_b_display_name"></a> [tunnel\_b\_display\_name](#input\_tunnel\_b\_display\_name) | n/a | `any` | n/a | yes |
| <a name="input_vault_replica_region"></a> [vault\_replica\_region](#input\_vault\_replica\_region) | the region to be created replica to. | `string` | n/a | yes |
| <a name="input_vault_type"></a> [vault\_type](#input\_vault\_type) | The type of vault to create. | `string` | n/a | yes |
| <a name="input_vcn_cidr_block"></a> [vcn\_cidr\_block](#input\_vcn\_cidr\_block) | Hub VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_virtual_circuit_bandwidth_shape"></a> [virtual\_circuit\_bandwidth\_shape](#input\_virtual\_circuit\_bandwidth\_shape) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_customer_asn"></a> [virtual\_circuit\_customer\_asn](#input\_virtual\_circuit\_customer\_asn) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_display_name"></a> [virtual\_circuit\_display\_name](#input\_virtual\_circuit\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_is_bfd_enabled"></a> [virtual\_circuit\_is\_bfd\_enabled](#input\_virtual\_circuit\_is\_bfd\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_virtual_circuit_type"></a> [virtual\_circuit\_type](#input\_virtual\_circuit\_type) | n/a | `string` | n/a | yes |
| <a name="input_workload_admin_group_name"></a> [workload\_admin\_group\_name](#input\_workload\_admin\_group\_name) | The group name for the OCI Workload Administrators Group | `string` | `""` | no |
| <a name="input_workload_compartment_names"></a> [workload\_compartment\_names](#input\_workload\_compartment\_names) | The names of the workload compartments to update policies for the Admin Groups | `list(string)` | `[]` | no |
| <a name="input_workload_name_prefix"></a> [workload\_name\_prefix](#input\_workload\_name\_prefix) | Workload Compartment Name Prefix | `string` | n/a | yes |
| <a name="input_workload_topic_endpoints"></a> [workload\_topic\_endpoints](#input\_workload\_topic\_endpoints) | List of email addresses for Workload notifications. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_compartment"></a> [compartment](#output\_compartment) | n/a |
| <a name="output_default_group_id"></a> [default\_group\_id](#output\_default\_group\_id) | n/a |
| <a name="output_drg_id"></a> [drg\_id](#output\_drg\_id) | n/a |
| <a name="output_hub_private_subnet_cidr"></a> [hub\_private\_subnet\_cidr](#output\_hub\_private\_subnet\_cidr) | n/a |
| <a name="output_hub_public_subnet_cidr"></a> [hub\_public\_subnet\_cidr](#output\_hub\_public\_subnet\_cidr) | n/a |
| <a name="output_identity_domain"></a> [identity\_domain](#output\_identity\_domain) | n/a |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | n/a |
| <a name="output_rpc_id"></a> [rpc\_id](#output\_rpc\_id) | n/a |
| <a name="output_stream_id"></a> [stream\_id](#output\_stream\_id) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The subnet OCID |
| <a name="output_vault_id"></a> [vault\_id](#output\_vault\_id) | n/a |
| <a name="output_vcn"></a> [vcn](#output\_vcn) | n/a |
| <a name="output_workload_compartment_id"></a> [workload\_compartment\_id](#output\_workload\_compartment\_id) | n/a |
| <a name="output_workload_compartment_name"></a> [workload\_compartment\_name](#output\_workload\_compartment\_name) | n/a |
| <a name="output_workload_subnet_cidr_blocks"></a> [workload\_subnet\_cidr\_blocks](#output\_workload\_subnet\_cidr\_blocks) | n/a |
<!-- END_TF_DOCS -->    
