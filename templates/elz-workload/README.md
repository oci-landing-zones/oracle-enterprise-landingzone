<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 4.96.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.96.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_groups"></a> [groups](#module\_groups) | ../../modules/identity-domain-group | n/a |
| <a name="module_spoke_workload_compartment"></a> [spoke\_workload\_compartment](#module\_spoke\_workload\_compartment) | ../elz-spoke | n/a |
| <a name="module_workload_compartment"></a> [workload\_compartment](#module\_workload\_compartment) | ../../modules/compartment | n/a |
| <a name="module_workload_critical_topic"></a> [workload\_critical\_topic](#module\_workload\_critical\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_workload_expansion_policy"></a> [workload\_expansion\_policy](#module\_workload\_expansion\_policy) | ../../modules/policies | n/a |
| <a name="module_workload_expansion_sec_policy"></a> [workload\_expansion\_sec\_policy](#module\_workload\_expansion\_sec\_policy) | ../../modules/policies | n/a |
| <a name="module_workload_warning_topic"></a> [workload\_warning\_topic](#module\_workload\_warning\_topic) | ../../modules/notification-topic | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/4.96.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_admin_group_name"></a> [application\_admin\_group\_name](#input\_application\_admin\_group\_name) | the name of workload application admin group | `string` | `""` | no |
| <a name="input_database_admin_group_name"></a> [database\_admin\_group\_name](#input\_database\_admin\_group\_name) | the name of workload database admin group | `string` | `""` | no |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | n/a | `string` | `"ocid1.drg."` | no |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy. | `bool` | `true` | no |
| <a name="input_enable_internet_gateway_spoke"></a> [enable\_internet\_gateway\_spoke](#input\_enable\_internet\_gateway\_spoke) | n/a | `bool` | `false` | no |
| <a name="input_enable_nat_gateway_spoke"></a> [enable\_nat\_gateway\_spoke](#input\_enable\_nat\_gateway\_spoke) | n/a | `bool` | `false` | no |
| <a name="input_enable_network_monitoring_alarms"></a> [enable\_network\_monitoring\_alarms](#input\_enable\_network\_monitoring\_alarms) | Enable Network Monitoring Alarms in Network Compartment | `bool` | `false` | no |
| <a name="input_enable_security_monitoring_alarms"></a> [enable\_security\_monitoring\_alarms](#input\_enable\_security\_monitoring\_alarms) | Enable Security Monitoring Alarms in Security Compartment | `bool` | `false` | no |
| <a name="input_enable_service_gateway_spoke"></a> [enable\_service\_gateway\_spoke](#input\_enable\_service\_gateway\_spoke) | n/a | `bool` | `false` | no |
| <a name="input_enable_workload_monitoring_alarms"></a> [enable\_workload\_monitoring\_alarms](#input\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Workload Compartment | `bool` | `false` | no |
| <a name="input_environment_compartment_id"></a> [environment\_compartment\_id](#input\_environment\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_hub_private_subnet_cidr_block"></a> [hub\_private\_subnet\_cidr\_block](#input\_hub\_private\_subnet\_cidr\_block) | n/a | `string` | `"10.1.2.0/24"` | no |
| <a name="input_hub_public_subnet_cidr_block"></a> [hub\_public\_subnet\_cidr\_block](#input\_hub\_public\_subnet\_cidr\_block) | n/a | `string` | `"10.1.1.0/24"` | no |
| <a name="input_hub_route_table_name"></a> [hub\_route\_table\_name](#input\_hub\_route\_table\_name) | n/a | `string` | `""` | no |
| <a name="input_hub_security_list_id"></a> [hub\_security\_list\_id](#input\_hub\_security\_list\_id) | n/a | `string` | `"ocid1.securitylist."` | no |
| <a name="input_hub_vcn_id"></a> [hub\_vcn\_id](#input\_hub\_vcn\_id) | n/a | `string` | `"ocid1.vcn."` | no |
| <a name="input_hub_vcn_parent_compartment_id"></a> [hub\_vcn\_parent\_compartment\_id](#input\_hub\_vcn\_parent\_compartment\_id) | n/a | `string` | `"ocid1.compartment."` | no |
| <a name="input_identity_domain_id"></a> [identity\_domain\_id](#input\_identity\_domain\_id) | the ocid of identity domain | `string` | `"ocid1.domain."` | no |
| <a name="input_identity_domain_name"></a> [identity\_domain\_name](#input\_identity\_domain\_name) | identity domain name | `string` | `""` | no |
| <a name="input_internet_gateway_display_name"></a> [internet\_gateway\_display\_name](#input\_internet\_gateway\_display\_name) | (Updatable) Name of Internet Gateway. Does not have to be unique. | `string` | `"igw"` | no |
| <a name="input_nat_gateway_display_name"></a> [nat\_gateway\_display\_name](#input\_nat\_gateway\_display\_name) | (Updatable) Name of NAT Gateway. Does not have to be unique. | `string` | `"ngw"` | no |
| <a name="input_nat_gw_spoke_check"></a> [nat\_gw\_spoke\_check](#input\_nat\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_network_admin_group_name"></a> [network\_admin\_group\_name](#input\_network\_admin\_group\_name) | Network Admin Group Name. | `string` | `""` | no |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | `""` | no |
| <a name="input_network_topic_endpoints"></a> [network\_topic\_endpoints](#input\_network\_topic\_endpoints) | List of email addresses for Network Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_route_table_display_name"></a> [route\_table\_display\_name](#input\_route\_table\_display\_name) | Workload Expansion Spoke Route Table Name Disply Name. | `string` | `""` | no |
| <a name="input_secops_topic_endpoints"></a> [secops\_topic\_endpoints](#input\_secops\_topic\_endpoints) | List of email addresses for Secops Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_security_admin_group_name"></a> [security\_admin\_group\_name](#input\_security\_admin\_group\_name) | Security Admin Group Name. | `string` | `""` | no |
| <a name="input_security_compartment_id"></a> [security\_compartment\_id](#input\_security\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | `""` | no |
| <a name="input_security_compartment_name"></a> [security\_compartment\_name](#input\_security\_compartment\_name) | Security Compartment Name. | `string` | `""` | no |
| <a name="input_security_compartment_ocid"></a> [security\_compartment\_ocid](#input\_security\_compartment\_ocid) | Security Compartment OCID. | `string` | `""` | no |
| <a name="input_security_list_display_name"></a> [security\_list\_display\_name](#input\_security\_list\_display\_name) | Workload Expansion Spoke Security List Name Disly Name. | `string` | `""` | no |
| <a name="input_service_gateway_display_name"></a> [service\_gateway\_display\_name](#input\_service\_gateway\_display\_name) | (Updatable) Name of Service Gateway. Does not have to be unique. | `string` | `"sgw"` | no |
| <a name="input_service_gw_spoke_check"></a> [service\_gw\_spoke\_check](#input\_service\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name) | Workload Expansion Spoke VCN Display Name | `string` | `""` | no |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"wrkspokevcn"` | no |
| <a name="input_workload_admin_group_name"></a> [workload\_admin\_group\_name](#input\_workload\_admin\_group\_name) | the name of workload admin group | `string` | `""` | no |
| <a name="input_workload_compartment_name"></a> [workload\_compartment\_name](#input\_workload\_compartment\_name) | The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>. | `string` | `""` | no |
| <a name="input_workload_expansion_flag"></a> [workload\_expansion\_flag](#input\_workload\_expansion\_flag) | Set to true if you want to use this as independent Workload Expansion Deployment Stack. | `bool` | `false` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | The name of the workload. | `string` | `""` | no |
| <a name="input_workload_prefix"></a> [workload\_prefix](#input\_workload\_prefix) | Atleast 4 Alphanumeric Charater to Describe the Workload : WRK1 | `string` | `"WRK1"` | no |
| <a name="input_workload_private_spoke_subnet_app_cidr_block"></a> [workload\_private\_spoke\_subnet\_app\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_app\_cidr\_block) | Workload Enivornment Spoke VCN CIDR Block. | `string` | `"10.5.2.0/24"` | no |
| <a name="input_workload_private_spoke_subnet_app_display_name"></a> [workload\_private\_spoke\_subnet\_app\_display\_name](#input\_workload\_private\_spoke\_subnet\_app\_display\_name) | Workload Expansion Spoke App Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_app_dns_label"></a> [workload\_private\_spoke\_subnet\_app\_dns\_label](#input\_workload\_private\_spoke\_subnet\_app\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"wrkapplabel"` | no |
| <a name="input_workload_private_spoke_subnet_db_cidr_block"></a> [workload\_private\_spoke\_subnet\_db\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_db\_cidr\_block) | Workload Enivornment Spoke VCN CIDR Block. | `string` | `"10.5.3.0/24"` | no |
| <a name="input_workload_private_spoke_subnet_db_display_name"></a> [workload\_private\_spoke\_subnet\_db\_display\_name](#input\_workload\_private\_spoke\_subnet\_db\_display\_name) | Workload Expansion Spoke Db Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_db_dns_label"></a> [workload\_private\_spoke\_subnet\_db\_dns\_label](#input\_workload\_private\_spoke\_subnet\_db\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"wrkdblabel"` | no |
| <a name="input_workload_private_spoke_subnet_web_cidr_block"></a> [workload\_private\_spoke\_subnet\_web\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_web\_cidr\_block) | Workload Enivornment Spoke VCN CIDR Block. | `string` | `"10.5.1.0/24"` | no |
| <a name="input_workload_private_spoke_subnet_web_display_name"></a> [workload\_private\_spoke\_subnet\_web\_display\_name](#input\_workload\_private\_spoke\_subnet\_web\_display\_name) | Workload Expansion Spoke Web Subnet Display Name. | `string` | `""` | no |
| <a name="input_workload_private_spoke_subnet_web_dns_label"></a> [workload\_private\_spoke\_subnet\_web\_dns\_label](#input\_workload\_private\_spoke\_subnet\_web\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | `"wrkweblabel"` | no |
| <a name="input_workload_spoke_vcn_cidr"></a> [workload\_spoke\_vcn\_cidr](#input\_workload\_spoke\_vcn\_cidr) | The list of IPv4 CIDR blocks the VCN will use. | `list(string)` | <pre>[<br>  "10.5.0.0/16"<br>]</pre> | no |
| <a name="input_workload_topic_endpoints"></a> [workload\_topic\_endpoints](#input\_workload\_topic\_endpoints) | List of email addresses for Workload notifications. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartment_id"></a> [compartment\_id](#output\_compartment\_id) | The ocid of workload compartment |
| <a name="output_compartment_name"></a> [compartment\_name](#output\_compartment\_name) | The Workload Compartment Name |
<!-- END_TF_DOCS -->