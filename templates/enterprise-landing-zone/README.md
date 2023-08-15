# Oracle Enterprise Landing Zone 

Version 2 of Oracle Enterprise Landing Zone

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
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_architecture_tag"></a> [architecture\_tag](#module\_architecture\_tag) | ../../modules/tag | n/a |
| <a name="module_archive_bucket"></a> [archive\_bucket](#module\_archive\_bucket) | ../../modules/bucket | n/a |
| <a name="module_archive_key"></a> [archive\_key](#module\_archive\_key) | ../../modules/key | n/a |
| <a name="module_authentication_policy"></a> [authentication\_policy](#module\_authentication\_policy) | ../../modules/authentication-policy | n/a |
| <a name="module_break_glass_users"></a> [break\_glass\_users](#module\_break\_glass\_users) | ../../modules/break_glass_user | n/a |
| <a name="module_cloud_guard_root_policy"></a> [cloud\_guard\_root\_policy](#module\_cloud\_guard\_root\_policy) | ../../modules/policies | n/a |
| <a name="module_cloud_guard_target_policy"></a> [cloud\_guard\_target\_policy](#module\_cloud\_guard\_target\_policy) | ../../modules/policies | n/a |
| <a name="module_home_compartment"></a> [home\_compartment](#module\_home\_compartment) | ../../modules/compartment | n/a |
| <a name="module_key_archive_policy"></a> [key\_archive\_policy](#module\_key\_archive\_policy) | ../../modules/policies | n/a |
| <a name="module_log_analytics_policy"></a> [log\_analytics\_policy](#module\_log\_analytics\_policy) | ../../modules/policies | n/a |
| <a name="module_logging_analytics_namespace"></a> [logging\_analytics\_namespace](#module\_logging\_analytics\_namespace) | ../../modules/log-analytics-namespace | n/a |
| <a name="module_nonprod_archive_audit_log_service_connector"></a> [nonprod\_archive\_audit\_log\_service\_connector](#module\_nonprod\_archive\_audit\_log\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_nonprod_archive_default_log_service_connector"></a> [nonprod\_archive\_default\_log\_service\_connector](#module\_nonprod\_archive\_default\_log\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_nonprod_archive_service_events_service_connector"></a> [nonprod\_archive\_service\_events\_service\_connector](#module\_nonprod\_archive\_service\_events\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_nonprod_environment"></a> [nonprod\_environment](#module\_nonprod\_environment) | ../elz-environment | n/a |
| <a name="module_nonprod_platform_admin_policy"></a> [nonprod\_platform\_admin\_policy](#module\_nonprod\_platform\_admin\_policy) | ../../modules/policies | n/a |
| <a name="module_osms_dg_policy"></a> [osms\_dg\_policy](#module\_osms\_dg\_policy) | ../../modules/policies | n/a |
| <a name="module_osms_dynamic_group"></a> [osms\_dynamic\_group](#module\_osms\_dynamic\_group) | ../../modules/dynamic-group | n/a |
| <a name="module_osms_policy"></a> [osms\_policy](#module\_osms\_policy) | ../../modules/policies | n/a |
| <a name="module_prod_archive_audit_log_service_connector"></a> [prod\_archive\_audit\_log\_service\_connector](#module\_prod\_archive\_audit\_log\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_prod_archive_default_log_service_connector"></a> [prod\_archive\_default\_log\_service\_connector](#module\_prod\_archive\_default\_log\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_prod_archive_service_events_service_connector"></a> [prod\_archive\_service\_events\_service\_connector](#module\_prod\_archive\_service\_events\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_prod_environment"></a> [prod\_environment](#module\_prod\_environment) | ../elz-environment | n/a |
| <a name="module_prod_platform_admin_policy"></a> [prod\_platform\_admin\_policy](#module\_prod\_platform\_admin\_policy) | ../../modules/policies | n/a |
| <a name="module_service_connector_archive_policy"></a> [service\_connector\_archive\_policy](#module\_service\_connector\_archive\_policy) | ../../modules/policies | n/a |
| <a name="module_service_connector_policy"></a> [service\_connector\_policy](#module\_service\_connector\_policy) | ../../modules/policies | n/a |
| <a name="module_vault_policy"></a> [vault\_policy](#module\_vault\_policy) | ../../modules/policies | n/a |
| <a name="module_vss_policy"></a> [vss\_policy](#module\_vss\_policy) | ../../modules/policies | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |
| [oci_objectstorage_namespace.ns](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/objectstorage_namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint) | The fingerprint of API | `string` | `""` | no |
| <a name="input_api_private_key"></a> [api\_private\_key](#input\_api\_private\_key) | The API private key | `string` | `""` | no |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key | `string` | `""` | no |
| <a name="input_archive_external_master_encryption_key"></a> [archive\_external\_master\_encryption\_key](#input\_archive\_external\_master\_encryption\_key) | OCID of existing key to use (instead of creating a new MEK) | `string` | `""` | no |
| <a name="input_archive_log_retention_policy_duration_amount"></a> [archive\_log\_retention\_policy\_duration\_amount](#input\_archive\_log\_retention\_policy\_duration\_amount) | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | `"1"` | no |
| <a name="input_archive_log_retention_policy_duration_time_unit"></a> [archive\_log\_retention\_policy\_duration\_time\_unit](#input\_archive\_log\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount. | `string` | `"DAYS"` | no |
| <a name="input_bgp_md5auth_key"></a> [bgp\_md5auth\_key](#input\_bgp\_md5auth\_key) | The key for BGP MD5 authentication. Only applicable if your system requires MD5 authentication | `string` | `""` | no |
| <a name="input_break_glass_user_email_list"></a> [break\_glass\_user\_email\_list](#input\_break\_glass\_user\_email\_list) | Unique list of break glass user email addresses that do not exist in the tenancy. These users are added to the Administrator group. | `list(string)` | `[]` | no |
| <a name="input_cloud_guard_target_tenancy"></a> [cloud\_guard\_target\_tenancy](#input\_cloud\_guard\_target\_tenancy) | true if cloud guard targets to tenancy, false if cloud guard targets to Landing Zone home compartment | `bool` | `false` | no |
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid) | The OCID of the current user | `string` | `""` | no |
| <a name="input_customer_onprem_ip_cidr"></a> [customer\_onprem\_ip\_cidr](#input\_customer\_onprem\_ip\_cidr) | n/a | `list(string)` | `[]` | no |
| <a name="input_customer_primary_bgp_peering_ip"></a> [customer\_primary\_bgp\_peering\_ip](#input\_customer\_primary\_bgp\_peering\_ip) | The primary BGP IPv4 address of the customer's router | `string` | `""` | no |
| <a name="input_customer_secondary_bgp_peering_ip"></a> [customer\_secondary\_bgp\_peering\_ip](#input\_customer\_secondary\_bgp\_peering\_ip) | [Optional] The secondary BGP IPv4 address of the customer's router | `string` | `""` | no |
| <a name="input_domain_license_type"></a> [domain\_license\_type](#input\_domain\_license\_type) | Identity Domain License Type | `string` | `"premium"` | no |
| <a name="input_enable_cloud_guard"></a> [enable\_cloud\_guard](#input\_enable\_cloud\_guard) | true if you don't have cloud guard enabled, false if you've already have cloud guard enabled. | `bool` | `true` | no |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy. | `bool` | `true` | no |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT. | `string` | `"NONE"` | no |
| <a name="input_fastconnect_provider"></a> [fastconnect\_provider](#input\_fastconnect\_provider) | Fastconnect provider. Please choose from: AT&T, Azure, Megaport, QTS, CEintro, Cologix, CoreSite, Digitial Realty, EdgeConneX, Epsilon, Equinix, InterCloud, Lumen, Neutrona, OMCS, OracleL2ItegDeployment, OracleL3ItegDeployment, Orange, Verizon, Zayo | `string` | `""` | no |
| <a name="input_fastconnect_routing_policy"></a> [fastconnect\_routing\_policy](#input\_fastconnect\_routing\_policy) | Available FastConnect routing policies: ORACLE\_SERVICE\_NETWORK, REGIONAL, MARKET\_LEVEL, GLOBAL | `list(string)` | `[]` | no |
| <a name="input_home_compartment_name"></a> [home\_compartment\_name](#input\_home\_compartment\_name) | The name of the Landing Zone home compartment. | `string` | `"OCI-ELZ-CMP-HOME"` | no |
| <a name="input_igw_hub_check"></a> [igw\_hub\_check](#input\_igw\_hub\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Set to True(if the deployment is baseline) to disable dependent module TagNameSpace Tag Creation. | `bool` | `true` | no |
| <a name="input_is_create_alarms"></a> [is\_create\_alarms](#input\_is\_create\_alarms) | Enable Alarms Creation in all Compartment | `bool` | `true` | no |
| <a name="input_is_service_connector_limit"></a> [is\_service\_connector\_limit](#input\_is\_service\_connector\_limit) | Restrict Number of Service Connector Deployment in Tenancy if limit is two | `bool` | `false` | no |
| <a name="input_nat_gw_hub_check"></a> [nat\_gw\_hub\_check](#input\_nat\_gw\_hub\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_nat_gw_spoke_check"></a> [nat\_gw\_spoke\_check](#input\_nat\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_nonprod_additional_workload_subnets_cidr_blocks"></a> [nonprod\_additional\_workload\_subnets\_cidr\_blocks](#input\_nonprod\_additional\_workload\_subnets\_cidr\_blocks) | A list of subnets cidr blocks in additional workload stack in non-prod | `list(string)` | `[]` | no |
| <a name="input_nonprod_application_admin_group_name"></a> [nonprod\_application\_admin\_group\_name](#input\_nonprod\_application\_admin\_group\_name) | The group name for the OCI Application Administrators Group. Defaults to OCI-ELZ-UGP-N-APP-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_bastion_client_cidr_block_allow_list"></a> [nonprod\_bastion\_client\_cidr\_block\_allow\_list](#input\_nonprod\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. | `list(string)` | n/a | yes |
| <a name="input_nonprod_bgp_cust_tunnela_ip"></a> [nonprod\_bgp\_cust\_tunnela\_ip](#input\_nonprod\_bgp\_cust\_tunnela\_ip) | The IP address for the CPE end of the inside tunnel interface. | `string` | `""` | no |
| <a name="input_nonprod_bgp_oci_tunnela_ip"></a> [nonprod\_bgp\_oci\_tunnela\_ip](#input\_nonprod\_bgp\_oci\_tunnela\_ip) | The IP address for the Oracle end of the inside tunnel interface. | `string` | `""` | no |
| <a name="input_nonprod_budget_alert_rule_message"></a> [nonprod\_budget\_alert\_rule\_message](#input\_nonprod\_budget\_alert\_rule\_message) | The alert message for budget alerts. Required *if* nonprod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_nonprod_budget_alert_rule_recipients"></a> [nonprod\_budget\_alert\_rule\_recipients](#input\_nonprod\_budget\_alert\_rule\_recipients) | The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon. Required *if* nonprod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_nonprod_budget_alert_rule_threshold"></a> [nonprod\_budget\_alert\_rule\_threshold](#input\_nonprod\_budget\_alert\_rule\_threshold) | The threshold for the budget alert. Required *if* nonprod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_nonprod_budget_amount"></a> [nonprod\_budget\_amount](#input\_nonprod\_budget\_amount) | The amount of the budget expressed as a whole number in the currency of the customer's rate card. Required *if* nonprod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_nonprod_cost_center_tagging"></a> [nonprod\_cost\_center\_tagging](#input\_nonprod\_cost\_center\_tagging) | Non-ProductionGeo Location. | `string` | n/a | yes |
| <a name="input_nonprod_cpe_display_name"></a> [nonprod\_cpe\_display\_name](#input\_nonprod\_cpe\_display\_name) | Customer Premises Equipment name. Recommendation: OCI-ELZ-CPE-[Environment]-HUB-[Region] 001 | `string` | `""` | no |
| <a name="input_nonprod_cpe_ip_address"></a> [nonprod\_cpe\_ip\_address](#input\_nonprod\_cpe\_ip\_address) | Customer Premises Equipment (CPE) IP address | `string` | `""` | no |
| <a name="input_nonprod_cpe_vendor"></a> [nonprod\_cpe\_vendor](#input\_nonprod\_cpe\_vendor) | Type corresponding number as your CPE vendor: Yamaha-RTX1210 0, Other 1, Cisco-9.7.1-or-later 2, Yamaha-RTX830 3, Libreswan 4, Fortinet 5, NEC 6, Cisco-8.5+ 7, Cisco-IOS 8, WatchGuard 9, Juniper-MX 10, Juniper-SRX 11, Furukawa 12, Check\_Point 13, Palo\_Alto 14 | `number` | `0` | no |
| <a name="input_nonprod_create_master_encryption_key"></a> [nonprod\_create\_master\_encryption\_key](#input\_nonprod\_create\_master\_encryption\_key) | Option create master encryption key | `bool` | `true` | no |
| <a name="input_nonprod_customer_bgp_asn"></a> [nonprod\_customer\_bgp\_asn](#input\_nonprod\_customer\_bgp\_asn) | ASN is required and used for the tunnel's BGP session | `string` | `""` | no |
| <a name="input_nonprod_database_admin_group_name"></a> [nonprod\_database\_admin\_group\_name](#input\_nonprod\_database\_admin\_group\_name) | The group name for the OCI Database Logging Administrators Group. Defaults to OCI-ELZ-UGP-N-DB-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_domain_admin_email"></a> [nonprod\_domain\_admin\_email](#input\_nonprod\_domain\_admin\_email) | The email address for the non prod identity domain admin. | `string` | n/a | yes |
| <a name="input_nonprod_enable_bastion"></a> [nonprod\_enable\_bastion](#input\_nonprod\_enable\_bastion) | Option to enable bastion service | `bool` | n/a | yes |
| <a name="input_nonprod_enable_budget"></a> [nonprod\_enable\_budget](#input\_nonprod\_enable\_budget) | n/a | `bool` | n/a | yes |
| <a name="input_nonprod_enable_fastconnect"></a> [nonprod\_enable\_fastconnect](#input\_nonprod\_enable\_fastconnect) | [Please don't change this value] Enable fastconnect in non prod environment. | `bool` | `false` | no |
| <a name="input_nonprod_enable_internet_gateway_hub"></a> [nonprod\_enable\_internet\_gateway\_hub](#input\_nonprod\_enable\_internet\_gateway\_hub) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_nonprod_enable_nat_gateway_hub"></a> [nonprod\_enable\_nat\_gateway\_hub](#input\_nonprod\_enable\_nat\_gateway\_hub) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_nonprod_enable_nat_gateway_spoke"></a> [nonprod\_enable\_nat\_gateway\_spoke](#input\_nonprod\_enable\_nat\_gateway\_spoke) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_nonprod_enable_network_monitoring_alarms"></a> [nonprod\_enable\_network\_monitoring\_alarms](#input\_nonprod\_enable\_network\_monitoring\_alarms) | Enable Network Monitoring Alarms in Non-Production Network Compartment | `bool` | `false` | no |
| <a name="input_nonprod_enable_security_monitoring_alarms"></a> [nonprod\_enable\_security\_monitoring\_alarms](#input\_nonprod\_enable\_security\_monitoring\_alarms) | Enable Security Monitoring Alarms in Non-Production Security Compartment | `bool` | `false` | no |
| <a name="input_nonprod_enable_service_gateway_hub"></a> [nonprod\_enable\_service\_gateway\_hub](#input\_nonprod\_enable\_service\_gateway\_hub) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_nonprod_enable_service_gateway_spoke"></a> [nonprod\_enable\_service\_gateway\_spoke](#input\_nonprod\_enable\_service\_gateway\_spoke) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_nonprod_enable_tagging"></a> [nonprod\_enable\_tagging](#input\_nonprod\_enable\_tagging) | Option to enable Tagging gateway in Non-Production environment | `bool` | `false` | no |
| <a name="input_nonprod_enable_vault_replication"></a> [nonprod\_enable\_vault\_replication](#input\_nonprod\_enable\_vault\_replication) | Option to enable vault replication | `bool` | `false` | no |
| <a name="input_nonprod_enable_vpn"></a> [nonprod\_enable\_vpn](#input\_nonprod\_enable\_vpn) | Enable VPN in non prod environment | `bool` | `false` | no |
| <a name="input_nonprod_enable_workload_monitoring_alarms"></a> [nonprod\_enable\_workload\_monitoring\_alarms](#input\_nonprod\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Non-Production Workload Compartment | `bool` | `false` | no |
| <a name="input_nonprod_external_master_encryption_key"></a> [nonprod\_external\_master\_encryption\_key](#input\_nonprod\_external\_master\_encryption\_key) | OCID of existing key to use (instead of creating a new MEK) | `string` | `""` | no |
| <a name="input_nonprod_geo_location_tagging"></a> [nonprod\_geo\_location\_tagging](#input\_nonprod\_geo\_location\_tagging) | Non-Production Geo Location. | `string` | n/a | yes |
| <a name="input_nonprod_hub_private_subnet_cidr_block"></a> [nonprod\_hub\_private\_subnet\_cidr\_block](#input\_nonprod\_hub\_private\_subnet\_cidr\_block) | Non-Production Enivornment HUB Private Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_hub_public_subnet_cidr_block"></a> [nonprod\_hub\_public\_subnet\_cidr\_block](#input\_nonprod\_hub\_public\_subnet\_cidr\_block) | Non-Production Enivornment HUB Public Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_hub_vcn_cidr_block"></a> [nonprod\_hub\_vcn\_cidr\_block](#input\_nonprod\_hub\_vcn\_cidr\_block) | Non-Production Enivornment HUB VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_iam_admin_group_name"></a> [nonprod\_iam\_admin\_group\_name](#input\_nonprod\_iam\_admin\_group\_name) | The group name for the OCI Landing Zone IAM Administrators Group. Defaults to OCI-ELZ-UGP-N-IDP-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_identity_topic_endpoints"></a> [nonprod\_identity\_topic\_endpoints](#input\_nonprod\_identity\_topic\_endpoints) | List of email addresses for Identity notifications. | `list(string)` | `[]` | no |
| <a name="input_nonprod_ipsec_connection_static_routes"></a> [nonprod\_ipsec\_connection\_static\_routes](#input\_nonprod\_ipsec\_connection\_static\_routes) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_nonprod_ipsec_display_name"></a> [nonprod\_ipsec\_display\_name](#input\_nonprod\_ipsec\_display\_name) | IPsec display name. Recommendation: OCI-ELZ-IPS-[Environment]-HUB-[Region] 001 | `string` | `""` | no |
| <a name="input_nonprod_ipsec_routing_type"></a> [nonprod\_ipsec\_routing\_type](#input\_nonprod\_ipsec\_routing\_type) | BGP dynamic routing, STATIC routing. Type BGP or STATIC | `string` | `"STATIC"` | no |
| <a name="input_nonprod_network_admin_group_name"></a> [nonprod\_network\_admin\_group\_name](#input\_nonprod\_network\_admin\_group\_name) | The group name for the OCI Landing Zone Network Administrators Group. Defaults to OCI-ELZ-UGP-N-NET-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_network_topic_endpoints"></a> [nonprod\_network\_topic\_endpoints](#input\_nonprod\_network\_topic\_endpoints) | List of email addresses for Network Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_nonprod_ops_admin_group_name"></a> [nonprod\_ops\_admin\_group\_name](#input\_nonprod\_ops\_admin\_group\_name) | The group name for the OCI Landing Zone Ops Administrators Group. Defaults to OCI-ELZ-UGP-N-OPS-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_platform_admin_group_name"></a> [nonprod\_platform\_admin\_group\_name](#input\_nonprod\_platform\_admin\_group\_name) | The group name for the OCI Landing Zone Platform Administrators Group. Defaults to OCI-ELZ-UGP-N-PLT-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_platform_topic_endpoints"></a> [nonprod\_platform\_topic\_endpoints](#input\_nonprod\_platform\_topic\_endpoints) | List of email addresses for Platform notifications. | `list(string)` | `[]` | no |
| <a name="input_nonprod_retention_policy_duration_amount"></a> [nonprod\_retention\_policy\_duration\_amount](#input\_nonprod\_retention\_policy\_duration\_amount) | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | `"1"` | no |
| <a name="input_nonprod_retention_policy_duration_time_unit"></a> [nonprod\_retention\_policy\_duration\_time\_unit](#input\_nonprod\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount. | `string` | `"DAYS"` | no |
| <a name="input_nonprod_secops_topic_endpoints"></a> [nonprod\_secops\_topic\_endpoints](#input\_nonprod\_secops\_topic\_endpoints) | List of email addresses for Secops Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_nonprod_security_admin_group_name"></a> [nonprod\_security\_admin\_group\_name](#input\_nonprod\_security\_admin\_group\_name) | The group name for the OCI Landing Zone Security Administrators Group. Defaults to OCI-ELZ-UGP-N-SEC-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_shared_secret"></a> [nonprod\_shared\_secret](#input\_nonprod\_shared\_secret) | The shared secret (pre-shared key) to use for the IPSec tunnel | `string` | `"example"` | no |
| <a name="input_nonprod_spoke_subnet_app_cidr_block"></a> [nonprod\_spoke\_subnet\_app\_cidr\_block](#input\_nonprod\_spoke\_subnet\_app\_cidr\_block) | Non-Production Enivornment Spoke App Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_spoke_subnet_db_cidr_block"></a> [nonprod\_spoke\_subnet\_db\_cidr\_block](#input\_nonprod\_spoke\_subnet\_db\_cidr\_block) | Non-Production Enivornment Spoke DB Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_spoke_subnet_web_cidr_block"></a> [nonprod\_spoke\_subnet\_web\_cidr\_block](#input\_nonprod\_spoke\_subnet\_web\_cidr\_block) | Non-Production Enivornment Spoke Web Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_spoke_vcn_cidr"></a> [nonprod\_spoke\_vcn\_cidr](#input\_nonprod\_spoke\_vcn\_cidr) | Non-Production Enivornment Spoke VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_nonprod_tunnel_a_display_name"></a> [nonprod\_tunnel\_a\_display\_name](#input\_nonprod\_tunnel\_a\_display\_name) | Tunnel A display name. Recommendation: | `string` | `""` | no |
| <a name="input_nonprod_tunnel_b_display_name"></a> [nonprod\_tunnel\_b\_display\_name](#input\_nonprod\_tunnel\_b\_display\_name) | Tunnel B display name. Recommendation: | `string` | `""` | no |
| <a name="input_nonprod_vault_replica_region"></a> [nonprod\_vault\_replica\_region](#input\_nonprod\_vault\_replica\_region) | the region to be created replica to. Required *if* nonprod\_enable\_vault\_replication is true. | `string` | `""` | no |
| <a name="input_nonprod_vault_type"></a> [nonprod\_vault\_type](#input\_nonprod\_vault\_type) | The type of vault to create. | `string` | `"DEFAULT"` | no |
| <a name="input_nonprod_workload_admin_group_name"></a> [nonprod\_workload\_admin\_group\_name](#input\_nonprod\_workload\_admin\_group\_name) | The group name for the OCI Workload Administrators Group. Defaults to OCI-ELZ-UGP-N-WRK-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_nonprod_workload_compartment_names"></a> [nonprod\_workload\_compartment\_names](#input\_nonprod\_workload\_compartment\_names) | The names of the workload compartments to update policies for the Admin Groups | `list(string)` | `[]` | no |
| <a name="input_nonprod_workload_topic_endpoints"></a> [nonprod\_workload\_topic\_endpoints](#input\_nonprod\_workload\_topic\_endpoints) | List of email addresses for Non Prod Workload notifications. | `list(string)` | `[]` | no |
| <a name="input_onboard_log_analytics"></a> [onboard\_log\_analytics](#input\_onboard\_log\_analytics) | Set to true to onboard the tenancy to logging analytics. | `bool` | `true` | no |
| <a name="input_oracle_primary_bgp_peering_ip"></a> [oracle\_primary\_bgp\_peering\_ip](#input\_oracle\_primary\_bgp\_peering\_ip) | The primary BGP IPv4 address for Oracle's end of the BGP session | `string` | `""` | no |
| <a name="input_oracle_secondary_bgp_peering_ip"></a> [oracle\_secondary\_bgp\_peering\_ip](#input\_oracle\_secondary\_bgp\_peering\_ip) | [Optional] Secondary IPv4 address for Oracle's end of the BGP session | `string` | `""` | no |
| <a name="input_prod_additional_workload_subnets_cidr_blocks"></a> [prod\_additional\_workload\_subnets\_cidr\_blocks](#input\_prod\_additional\_workload\_subnets\_cidr\_blocks) | A list of subnets cidr blocks in additional workload stack in prod | `list(string)` | `[]` | no |
| <a name="input_prod_application_admin_group_name"></a> [prod\_application\_admin\_group\_name](#input\_prod\_application\_admin\_group\_name) | The group name for the OCI Application Administrators Group. Defaults to OCI-ELZ-UGP-P-APP-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_bastion_client_cidr_block_allow_list"></a> [prod\_bastion\_client\_cidr\_block\_allow\_list](#input\_prod\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. | `list(string)` | n/a | yes |
| <a name="input_prod_bgp_cust_tunnela_ip"></a> [prod\_bgp\_cust\_tunnela\_ip](#input\_prod\_bgp\_cust\_tunnela\_ip) | The IP address for the CPE end of the inside tunnel interface. | `string` | `""` | no |
| <a name="input_prod_bgp_oci_tunnela_ip"></a> [prod\_bgp\_oci\_tunnela\_ip](#input\_prod\_bgp\_oci\_tunnela\_ip) | The IP address for the Oracle end of the inside tunnel interface. | `string` | `""` | no |
| <a name="input_prod_budget_alert_rule_message"></a> [prod\_budget\_alert\_rule\_message](#input\_prod\_budget\_alert\_rule\_message) | The alert message for budget alerts. Required *if* prod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_prod_budget_alert_rule_recipients"></a> [prod\_budget\_alert\_rule\_recipients](#input\_prod\_budget\_alert\_rule\_recipients) | The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon. Required *if* prod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_prod_budget_alert_rule_threshold"></a> [prod\_budget\_alert\_rule\_threshold](#input\_prod\_budget\_alert\_rule\_threshold) | The threshold for the budget alert. Required *if* prod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_prod_budget_amount"></a> [prod\_budget\_amount](#input\_prod\_budget\_amount) | The amount of the budget expressed as a whole number in the currency of the customer's rate card. Required *if* prod\_enable\_budget is true. | `string` | `""` | no |
| <a name="input_prod_cost_center_tagging"></a> [prod\_cost\_center\_tagging](#input\_prod\_cost\_center\_tagging) | Production Cost Center. | `string` | n/a | yes |
| <a name="input_prod_cpe_display_name"></a> [prod\_cpe\_display\_name](#input\_prod\_cpe\_display\_name) | Customer Premises Equipment name. Recommendation: OCI-ELZ-CPE-[Environment]-HUB-[Region] 001 | `string` | `""` | no |
| <a name="input_prod_cpe_ip_address"></a> [prod\_cpe\_ip\_address](#input\_prod\_cpe\_ip\_address) | Customer Premises Equipment (CPE) IP address | `string` | `""` | no |
| <a name="input_prod_cpe_vendor"></a> [prod\_cpe\_vendor](#input\_prod\_cpe\_vendor) | Type corresponding number as your CPE vendor: Yamaha-RTX1210 0, Other 1, Cisco-9.7.1-or-later 2, Yamaha-RTX830 3, Libreswan 4, Fortinet 5, NEC 6, Cisco-8.5+ 7, Cisco-IOS 8, WatchGuard 9, Juniper-MX 10, Juniper-SRX 11, Furukawa 12, Check\_Point 13, Palo\_Alto 14 | `number` | `0` | no |
| <a name="input_prod_create_master_encryption_key"></a> [prod\_create\_master\_encryption\_key](#input\_prod\_create\_master\_encryption\_key) | Option create master encryption key | `bool` | `true` | no |
| <a name="input_prod_customer_bgp_asn"></a> [prod\_customer\_bgp\_asn](#input\_prod\_customer\_bgp\_asn) | ASN is required and used for the tunnel's BGP session | `string` | `""` | no |
| <a name="input_prod_database_admin_group_name"></a> [prod\_database\_admin\_group\_name](#input\_prod\_database\_admin\_group\_name) | The group name for the OCI Database Logging Administrators Group. Defaults to OCI-ELZ-UGP-P-DB-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_domain_admin_email"></a> [prod\_domain\_admin\_email](#input\_prod\_domain\_admin\_email) | The email address for the prod identity domain admin. | `string` | n/a | yes |
| <a name="input_prod_enable_bastion"></a> [prod\_enable\_bastion](#input\_prod\_enable\_bastion) | Option to enable bastion service | `bool` | n/a | yes |
| <a name="input_prod_enable_budget"></a> [prod\_enable\_budget](#input\_prod\_enable\_budget) | n/a | `bool` | n/a | yes |
| <a name="input_prod_enable_fastconnect"></a> [prod\_enable\_fastconnect](#input\_prod\_enable\_fastconnect) | [Please don't change this value] Enable fastconnect in prod environment. | `bool` | `true` | no |
| <a name="input_prod_enable_internet_gateway_hub"></a> [prod\_enable\_internet\_gateway\_hub](#input\_prod\_enable\_internet\_gateway\_hub) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_prod_enable_nat_gateway_hub"></a> [prod\_enable\_nat\_gateway\_hub](#input\_prod\_enable\_nat\_gateway\_hub) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_prod_enable_nat_gateway_spoke"></a> [prod\_enable\_nat\_gateway\_spoke](#input\_prod\_enable\_nat\_gateway\_spoke) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_prod_enable_network_monitoring_alarms"></a> [prod\_enable\_network\_monitoring\_alarms](#input\_prod\_enable\_network\_monitoring\_alarms) | Enable Network Monitoring Alarms in Production Network Compartment | `bool` | `false` | no |
| <a name="input_prod_enable_security_monitoring_alarms"></a> [prod\_enable\_security\_monitoring\_alarms](#input\_prod\_enable\_security\_monitoring\_alarms) | Enable Security Monitoring Alarms in Production Security Compartment | `bool` | `false` | no |
| <a name="input_prod_enable_service_gateway_hub"></a> [prod\_enable\_service\_gateway\_hub](#input\_prod\_enable\_service\_gateway\_hub) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_prod_enable_service_gateway_spoke"></a> [prod\_enable\_service\_gateway\_spoke](#input\_prod\_enable\_service\_gateway\_spoke) | Option to enable TRUE and Disable false. | `string` | `"false"` | no |
| <a name="input_prod_enable_tagging"></a> [prod\_enable\_tagging](#input\_prod\_enable\_tagging) | Option to enable Tagging gateway in Production environment | `bool` | `false` | no |
| <a name="input_prod_enable_vault_replication"></a> [prod\_enable\_vault\_replication](#input\_prod\_enable\_vault\_replication) | Option to enable vault replication | `bool` | `false` | no |
| <a name="input_prod_enable_vpn"></a> [prod\_enable\_vpn](#input\_prod\_enable\_vpn) | Enable VPN in prod environment | `bool` | `false` | no |
| <a name="input_prod_enable_workload_monitoring_alarms"></a> [prod\_enable\_workload\_monitoring\_alarms](#input\_prod\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Production Workload Compartment | `bool` | `false` | no |
| <a name="input_prod_external_master_encryption_key"></a> [prod\_external\_master\_encryption\_key](#input\_prod\_external\_master\_encryption\_key) | OCID of existing key to use (instead of creating a new MEK) | `string` | `""` | no |
| <a name="input_prod_geo_location_tagging"></a> [prod\_geo\_location\_tagging](#input\_prod\_geo\_location\_tagging) | Production Geo Center. | `string` | n/a | yes |
| <a name="input_prod_hub_private_subnet_cidr_block"></a> [prod\_hub\_private\_subnet\_cidr\_block](#input\_prod\_hub\_private\_subnet\_cidr\_block) | Production Enivornment HUB Private Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_hub_public_subnet_cidr_block"></a> [prod\_hub\_public\_subnet\_cidr\_block](#input\_prod\_hub\_public\_subnet\_cidr\_block) | Production Enivornment HUB Public Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_hub_vcn_cidr_block"></a> [prod\_hub\_vcn\_cidr\_block](#input\_prod\_hub\_vcn\_cidr\_block) | Production Enivornment HUB VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_iam_admin_group_name"></a> [prod\_iam\_admin\_group\_name](#input\_prod\_iam\_admin\_group\_name) | The group name for the OCI Landing Zone IAM Administrators Group. Defaults to OCI-ELZ-UGP-P-IDP-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_identity_topic_endpoints"></a> [prod\_identity\_topic\_endpoints](#input\_prod\_identity\_topic\_endpoints) | List of email addresses for Identity notifications. | `list(string)` | `[]` | no |
| <a name="input_prod_ipsec_connection_static_routes"></a> [prod\_ipsec\_connection\_static\_routes](#input\_prod\_ipsec\_connection\_static\_routes) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_prod_ipsec_display_name"></a> [prod\_ipsec\_display\_name](#input\_prod\_ipsec\_display\_name) | IPsec display name. Recommendation: OCI-ELZ-IPS-[Environment]-HUB-[Region] 001 | `string` | `""` | no |
| <a name="input_prod_ipsec_routing_type"></a> [prod\_ipsec\_routing\_type](#input\_prod\_ipsec\_routing\_type) | BGP dynamic routing, STATIC routing. Type BGP or STATIC | `string` | `"STATIC"` | no |
| <a name="input_prod_network_admin_group_name"></a> [prod\_network\_admin\_group\_name](#input\_prod\_network\_admin\_group\_name) | The group name for the OCI Landing Zone Network Administrators Group. Defaults to OCI-ELZ-UGP-P-NET-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_network_topic_endpoints"></a> [prod\_network\_topic\_endpoints](#input\_prod\_network\_topic\_endpoints) | List of email addresses for Network Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_prod_ops_admin_group_name"></a> [prod\_ops\_admin\_group\_name](#input\_prod\_ops\_admin\_group\_name) | The group name for the OCI Landing Zone Ops Administrators Group. Defaults to OCI-ELZ-UGP-P-OPS-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_platform_admin_group_name"></a> [prod\_platform\_admin\_group\_name](#input\_prod\_platform\_admin\_group\_name) | The group name for the OCI Landing Zone Platform Administrators Group. Defaults to OCI-ELZ-UGP-P-PLT-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_platform_topic_endpoints"></a> [prod\_platform\_topic\_endpoints](#input\_prod\_platform\_topic\_endpoints) | List of email addresses for Platform notifications. | `list(string)` | `[]` | no |
| <a name="input_prod_retention_policy_duration_amount"></a> [prod\_retention\_policy\_duration\_amount](#input\_prod\_retention\_policy\_duration\_amount) | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | `"1"` | no |
| <a name="input_prod_retention_policy_duration_time_unit"></a> [prod\_retention\_policy\_duration\_time\_unit](#input\_prod\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount. | `string` | `"DAYS"` | no |
| <a name="input_prod_secops_topic_endpoints"></a> [prod\_secops\_topic\_endpoints](#input\_prod\_secops\_topic\_endpoints) | List of email addresses for Secops Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_prod_security_admin_group_name"></a> [prod\_security\_admin\_group\_name](#input\_prod\_security\_admin\_group\_name) | The group name for the OCI Landing Zone Security Administrators Group. Defaults to OCI-ELZ-UGP-P-SEC-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_shared_secret"></a> [prod\_shared\_secret](#input\_prod\_shared\_secret) | The shared secret (pre-shared key) to use for the IPSec tunnel | `string` | `"example"` | no |
| <a name="input_prod_spoke_subnet_app_cidr_block"></a> [prod\_spoke\_subnet\_app\_cidr\_block](#input\_prod\_spoke\_subnet\_app\_cidr\_block) | Production Enivornment Spoke App Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_spoke_subnet_db_cidr_block"></a> [prod\_spoke\_subnet\_db\_cidr\_block](#input\_prod\_spoke\_subnet\_db\_cidr\_block) | Production Enivornment Spoke DB Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_spoke_subnet_web_cidr_block"></a> [prod\_spoke\_subnet\_web\_cidr\_block](#input\_prod\_spoke\_subnet\_web\_cidr\_block) | Production Enivornment Spoke Web Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_spoke_vcn_cidr"></a> [prod\_spoke\_vcn\_cidr](#input\_prod\_spoke\_vcn\_cidr) | Production Enivornment Spoke VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_prod_tunnel_a_display_name"></a> [prod\_tunnel\_a\_display\_name](#input\_prod\_tunnel\_a\_display\_name) | Tunnel A display name. Recommendation: | `string` | `""` | no |
| <a name="input_prod_tunnel_b_display_name"></a> [prod\_tunnel\_b\_display\_name](#input\_prod\_tunnel\_b\_display\_name) | Tunnel B display name. Recommendation: | `string` | `""` | no |
| <a name="input_prod_vault_replica_region"></a> [prod\_vault\_replica\_region](#input\_prod\_vault\_replica\_region) | the region to be created replica to. Required *if* prod\_enable\_vault\_replication is true. | `string` | `""` | no |
| <a name="input_prod_vault_type"></a> [prod\_vault\_type](#input\_prod\_vault\_type) | The type of vault to create. | `string` | `"DEFAULT"` | no |
| <a name="input_prod_workload_admin_group_name"></a> [prod\_workload\_admin\_group\_name](#input\_prod\_workload\_admin\_group\_name) | The group name for the OCI Workload Administrators Group. Defaults to OCI-ELZ-UGP-P-WRK-ADMIN if blank or not provided. | `string` | `""` | no |
| <a name="input_prod_workload_compartment_names"></a> [prod\_workload\_compartment\_names](#input\_prod\_workload\_compartment\_names) | The names of the workload compartments to update policies for the Admin Groups | `list(string)` | `[]` | no |
| <a name="input_prod_workload_topic_endpoints"></a> [prod\_workload\_topic\_endpoints](#input\_prod\_workload\_topic\_endpoints) | List of email addresses for Prod Workload notifications. | `list(string)` | `[]` | no |
| <a name="input_provider_service_key_name"></a> [provider\_service\_key\_name](#input\_provider\_service\_key\_name) | The provider service key that the provider gives you when you set up a virtual circuit connection from the provider to OCI | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label) | A prefix used to avoid naming conflicts if multiple Landing Zones are deployed. | `string` | `""` | no |
| <a name="input_service_gw_hub_check"></a> [service\_gw\_hub\_check](#input\_service\_gw\_hub\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_service_gw_spoke_check"></a> [service\_gw\_spoke\_check](#input\_service\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_virtual_circuit_bandwidth_shape"></a> [virtual\_circuit\_bandwidth\_shape](#input\_virtual\_circuit\_bandwidth\_shape) | The provisioned data rate of the connection | `string` | `"1500"` | no |
| <a name="input_virtual_circuit_customer_asn"></a> [virtual\_circuit\_customer\_asn](#input\_virtual\_circuit\_customer\_asn) | The BGP ASN of the network at the other end of the BGP session from Oracle | `string` | `0` | no |
| <a name="input_virtual_circuit_display_name"></a> [virtual\_circuit\_display\_name](#input\_virtual\_circuit\_display\_name) | The display name of this virtual circuit. Recommendation: OCI-ELZ-FCN-P-HUB-[REGION] 001 | `string` | `""` | no |
| <a name="input_virtual_circuit_is_bfd_enabled"></a> [virtual\_circuit\_is\_bfd\_enabled](#input\_virtual\_circuit\_is\_bfd\_enabled) | Set to true to enable BFD for IPv4 BGP peering, or set to false to disable BFD | `bool` | `false` | no |
| <a name="input_virtual_circuit_type"></a> [virtual\_circuit\_type](#input\_virtual\_circuit\_type) | The type of IP addresses used in this virtual circuit. PRIVATE or PUBLIC | `string` | `""` | no |
| <a name="input_workload_name_prefix"></a> [workload\_name\_prefix](#input\_workload\_name\_prefix) | Workload Compartment Name Prefix | `string` | `"Workload1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamic_group_detail"></a> [dynamic\_group\_detail](#output\_dynamic\_group\_detail) | n/a |
| <a name="output_nonprod_environment"></a> [nonprod\_environment](#output\_nonprod\_environment) | n/a |
| <a name="output_prod_environment"></a> [prod\_environment](#output\_prod\_environment) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The subnet OCID |
| <a name="output_vcn"></a> [vcn](#output\_vcn) | n/a |
| <a name="output_workload_compartment_id"></a> [workload\_compartment\_id](#output\_workload\_compartment\_id) | n/a |
<!-- END_TF_DOCS -->    