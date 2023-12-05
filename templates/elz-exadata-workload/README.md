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
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../../modules/bastion | n/a |
| <a name="module_datasafe_admin_policy"></a> [datasafe\_admin\_policy](#module\_datasafe\_admin\_policy) | ../../modules/policies | n/a |
| <a name="module_exadata_workload_expansion_policy"></a> [exadata\_workload\_expansion\_policy](#module\_exadata\_workload\_expansion\_policy) | ../../modules/policies | n/a |
| <a name="module_exadata_workload_expansion_sec_policy"></a> [exadata\_workload\_expansion\_sec\_policy](#module\_exadata\_workload\_expansion\_sec\_policy) | ../../modules/policies | n/a |
| <a name="module_exadata_workload_expansion_spoke"></a> [exadata\_workload\_expansion\_spoke](#module\_exadata\_workload\_expansion\_spoke) | ../elz-exadata-spoke | n/a |
| <a name="module_groups"></a> [groups](#module\_groups) | ../../modules/identity-domain-group | n/a |
| <a name="module_osms_dynamic_group"></a> [osms\_dynamic\_group](#module\_osms\_dynamic\_group) | ../../modules/dynamic-group | n/a |
| <a name="module_vcn_flow_log"></a> [vcn\_flow\_log](#module\_vcn\_flow\_log) | ../../modules/service-log | n/a |
| <a name="module_workload_compartment"></a> [workload\_compartment](#module\_workload\_compartment) | ../../modules/compartment | n/a |
| <a name="module_workload_critical_topic"></a> [workload\_critical\_topic](#module\_workload\_critical\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_workload_warning_topic"></a> [workload\_warning\_topic](#module\_workload\_warning\_topic) | ../../modules/notification-topic | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint) | The fingerprint of API | `string` | `""` | no |
| <a name="input_api_private_key"></a> [api\_private\_key](#input\_api\_private\_key) | The API private key | `string` | `""` | no |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key | `string` | `""` | no |
| <a name="input_application_admin_group_name"></a> [application\_admin\_group\_name](#input\_application\_admin\_group\_name) | the name of workload application admin group | `string` | `""` | no |
| <a name="input_bastion_client_cidr_block_allow_list"></a> [bastion\_client\_cidr\_block\_allow\_list](#input\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. | `list(string)` | n/a | yes |
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid) | The OCID of the current user | `string` | `""` | no |
| <a name="input_customer_onprem_ip_cidr"></a> [customer\_onprem\_ip\_cidr](#input\_customer\_onprem\_ip\_cidr) | n/a | `list(string)` | `[]` | no |
| <a name="input_database_admin_group_name"></a> [database\_admin\_group\_name](#input\_database\_admin\_group\_name) | the name of workload database admin group | `string` | `""` | no |
| <a name="input_datasafe_admin_group_name"></a> [datasafe\_admin\_group\_name](#input\_datasafe\_admin\_group\_name) | the name of datasafe admin group | `string` | `""` | no |
| <a name="input_datasafe_reports_group_name"></a> [datasafe\_reports\_group\_name](#input\_datasafe\_reports\_group\_name) | the name of datasafe reports group | `string` | `""` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database Port. Default 1521. | `number` | `1521` | no |
| <a name="input_default_log_group_id"></a> [default\_log\_group\_id](#input\_default\_log\_group\_id) | Default Log Group ID | `string` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | n/a | `string` | n/a | yes |
| <a name="input_enable_bastion"></a> [enable\_bastion](#input\_enable\_bastion) | Option to enable bastion service | `bool` | n/a | yes |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy. | `bool` | `true` | no |
| <a name="input_enable_datasafe"></a> [enable\_datasafe](#input\_enable\_datasafe) | Enable DataSafe related IAM Group and Policies | `bool` | `false` | no |
| <a name="input_enable_fan_events"></a> [enable\_fan\_events](#input\_enable\_fan\_events) | Security List to be enabled for ONS FAN events | `bool` | `true` | no |
| <a name="input_enable_nat_gateway_spoke"></a> [enable\_nat\_gateway\_spoke](#input\_enable\_nat\_gateway\_spoke) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpn_on_environment"></a> [enable\_vpn\_on\_environment](#input\_enable\_vpn\_on\_environment) | n/a | `bool` | `false` | no |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | n/a | `string` | `"NONE"` | no |
| <a name="input_enable_workload_monitoring_alarms"></a> [enable\_workload\_monitoring\_alarms](#input\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Workload Compartment | `bool` | `false` | no |
| <a name="input_environment_compartment_id"></a> [environment\_compartment\_id](#input\_environment\_compartment\_id) | the OCID of the compartment where the environment was created. | `string` | n/a | yes |
| <a name="input_environment_compartment_name"></a> [environment\_compartment\_name](#input\_environment\_compartment\_name) | the name of the compartment where the environment was created. | `string` | `""` | no |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_exadata_infra_admin_group_name"></a> [exadata\_infra\_admin\_group\_name](#input\_exadata\_infra\_admin\_group\_name) | the name of exadata infrastructure admin group | `string` | `""` | no |
| <a name="input_hub_private_subnet_cidr_block"></a> [hub\_private\_subnet\_cidr\_block](#input\_hub\_private\_subnet\_cidr\_block) | n/a | `string` | `"10.1.2.0/24"` | no |
| <a name="input_hub_public_subnet_cidr_block"></a> [hub\_public\_subnet\_cidr\_block](#input\_hub\_public\_subnet\_cidr\_block) | n/a | `string` | `"10.1.1.0/24"` | no |
| <a name="input_hub_vcn_cidr_block"></a> [hub\_vcn\_cidr\_block](#input\_hub\_vcn\_cidr\_block) | CIDR of Hub VCN. | `string` | n/a | yes |
| <a name="input_hub_vcn_id"></a> [hub\_vcn\_id](#input\_hub\_vcn\_id) | OCID of Hub VCN. | `string` | n/a | yes |
| <a name="input_identity_domain_id"></a> [identity\_domain\_id](#input\_identity\_domain\_id) | the ocid of identity domain | `string` | `"ocid1.domain."` | no |
| <a name="input_identity_domain_name"></a> [identity\_domain\_name](#input\_identity\_domain\_name) | identity domain name | `string` | `""` | no |
| <a name="input_ipsec_connection_static_routes"></a> [ipsec\_connection\_static\_routes](#input\_ipsec\_connection\_static\_routes) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_is_create_alarms"></a> [is\_create\_alarms](#input\_is\_create\_alarms) | Enable Alarms Creation in all Compartment | `bool` | `true` | no |
| <a name="input_nat_gateway_display_name"></a> [nat\_gateway\_display\_name](#input\_nat\_gateway\_display\_name) | (Updatable) Name of NAT Gateway. Does not have to be unique. | `string` | `"ngw"` | no |
| <a name="input_nat_gw_spoke_check"></a> [nat\_gw\_spoke\_check](#input\_nat\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_network_admin_group_name"></a> [network\_admin\_group\_name](#input\_network\_admin\_group\_name) | the name of landing zone Network admin group | `string` | `""` | no |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label) | A prefix used to avoid naming conflicts if multiple Landing Zones are deployed. | `string` | `""` | no |
| <a name="input_route_table_display_name"></a> [route\_table\_display\_name](#input\_route\_table\_display\_name) | Workload Expansion Spoke Route Table Name Disply Name. | `string` | `""` | no |
| <a name="input_security_admin_group_name"></a> [security\_admin\_group\_name](#input\_security\_admin\_group\_name) | the name of landing zone Security admin group | `string` | `""` | no |
| <a name="input_security_compartment_id"></a> [security\_compartment\_id](#input\_security\_compartment\_id) | the OCID of the security compartment. | `string` | n/a | yes |
| <a name="input_security_compartment_name"></a> [security\_compartment\_name](#input\_security\_compartment\_name) | security compartment name under shared infra compartment | `string` | `""` | no |
| <a name="input_security_list_display_name"></a> [security\_list\_display\_name](#input\_security\_list\_display\_name) | Workload Expansion Spoke Security List Name Disly Name. | `string` | `""` | no |
| <a name="input_service_gateway_display_name"></a> [service\_gateway\_display\_name](#input\_service\_gateway\_display\_name) | (Updatable) Name of Service Gateway. Does not have to be unique. | `string` | `"sgw"` | no |
| <a name="input_service_gw_spoke_check"></a> [service\_gw\_spoke\_check](#input\_service\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name) | Workload Expansion Spoke VCN Display Name | `string` | `""` | no |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"spokelabel"` | no |
| <a name="input_workload_admin_group_name"></a> [workload\_admin\_group\_name](#input\_workload\_admin\_group\_name) | the name of workload admin group | `string` | `""` | no |
| <a name="input_workload_compartment_name"></a> [workload\_compartment\_name](#input\_workload\_compartment\_name) | The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>. | `string` | `""` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | The name of the workload that is using Exadata. | `string` | `"Exadata"` | no |
| <a name="input_workload_prefix"></a> [workload\_prefix](#input\_workload\_prefix) | Atleast 4 Alphanumeric Charater to Describe the Workload : WRK1 | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_app_cidr_block"></a> [workload\_private\_spoke\_subnet\_app\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_app\_cidr\_block) | Workload Enivornment Spoke App CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_app_display_name"></a> [workload\_private\_spoke\_subnet\_app\_display\_name](#input\_workload\_private\_spoke\_subnet\_app\_display\_name) | Workload Expansion Spoke App Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_app_dns_label"></a> [workload\_private\_spoke\_subnet\_app\_dns\_label](#input\_workload\_private\_spoke\_subnet\_app\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"appdnslabel"` | no |
| <a name="input_workload_private_spoke_subnet_backup_cidr_block"></a> [workload\_private\_spoke\_subnet\_backup\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_backup\_cidr\_block) | Workload Enivornment Spoke Backup CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_backup_display_name"></a> [workload\_private\_spoke\_subnet\_backup\_display\_name](#input\_workload\_private\_spoke\_subnet\_backup\_display\_name) | Workload Expansion Spoke Backup Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_backup_dns_label"></a> [workload\_private\_spoke\_subnet\_backup\_dns\_label](#input\_workload\_private\_spoke\_subnet\_backup\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"backupdnslabel"` | no |
| <a name="input_workload_private_spoke_subnet_client_cidr_block"></a> [workload\_private\_spoke\_subnet\_client\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_client\_cidr\_block) | Workload Enivornment Spoke Client CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_client_display_name"></a> [workload\_private\_spoke\_subnet\_client\_display\_name](#input\_workload\_private\_spoke\_subnet\_client\_display\_name) | Workload Expansion Spoke Client Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_client_dns_label"></a> [workload\_private\_spoke\_subnet\_client\_dns\_label](#input\_workload\_private\_spoke\_subnet\_client\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"clientdnslabel"` | no |
| <a name="input_workload_private_spoke_subnet_lb_cidr_block"></a> [workload\_private\_spoke\_subnet\_lb\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_lb\_cidr\_block) | Workload Enivornment Spoke LB CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_lb_display_name"></a> [workload\_private\_spoke\_subnet\_lb\_display\_name](#input\_workload\_private\_spoke\_subnet\_lb\_display\_name) | Workload Expansion Spoke LB Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_lb_dns_label"></a> [workload\_private\_spoke\_subnet\_lb\_dns\_label](#input\_workload\_private\_spoke\_subnet\_lb\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"lbdnslabel"` | no |
| <a name="input_workload_spoke_vcn_cidr"></a> [workload\_spoke\_vcn\_cidr](#input\_workload\_spoke\_vcn\_cidr) | IPv4 CIDR blocks the VCN will use. | `string` | n/a | yes |
| <a name="input_workload_topic_endpoints"></a> [workload\_topic\_endpoints](#input\_workload\_topic\_endpoints) | List of email addresses for Workload notifications. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workload"></a> [workload](#output\_workload) | n/a |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.