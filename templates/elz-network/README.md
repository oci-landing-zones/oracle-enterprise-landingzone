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
| <a name="module_hub"></a> [hub](#module\_hub) | ../elz-hub | n/a |
| <a name="module_spoke"></a> [spoke](#module\_spoke) | ../elz-spoke | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_ssh_to_security_list"></a> [add\_ssh\_to\_security\_list](#input\_add\_ssh\_to\_security\_list) | Add SSH tcpp port to Hub security list | `bool` | `false` | no |
| <a name="input_additional_workload_subnets_cidr_blocks"></a> [additional\_workload\_subnets\_cidr\_blocks](#input\_additional\_workload\_subnets\_cidr\_blocks) | A list of subnets cidr blocks in additional workload stack | `list(string)` | n/a | yes |
| <a name="input_customer_onprem_ip_cidr"></a> [customer\_onprem\_ip\_cidr](#input\_customer\_onprem\_ip\_cidr) | n/a | `list(string)` | n/a | yes |
| <a name="input_enable_fastconnect_on_environment"></a> [enable\_fastconnect\_on\_environment](#input\_enable\_fastconnect\_on\_environment) | n/a | `bool` | n/a | yes |
| <a name="input_enable_internet_gateway_hub"></a> [enable\_internet\_gateway\_hub](#input\_enable\_internet\_gateway\_hub) | Option to enable true and Disable false. | `string` | `"false"` | no |
| <a name="input_enable_nat_gateway_hub"></a> [enable\_nat\_gateway\_hub](#input\_enable\_nat\_gateway\_hub) | Option to enable true and Disable false. | `string` | `"false"` | no |
| <a name="input_enable_nat_gateway_spoke"></a> [enable\_nat\_gateway\_spoke](#input\_enable\_nat\_gateway\_spoke) | Option to enable true and Disable false. | `string` | `"false"` | no |
| <a name="input_enable_network_firewall"></a> [enable\_network\_firewall](#input\_enable\_network\_firewall) | Enable Network Firewall in Enviornment. | `bool` | n/a | yes |
| <a name="input_enable_service_gateway_hub"></a> [enable\_service\_gateway\_hub](#input\_enable\_service\_gateway\_hub) | Option to enable true and Disable false. | `string` | `"false"` | no |
| <a name="input_enable_service_gateway_spoke"></a> [enable\_service\_gateway\_spoke](#input\_enable\_service\_gateway\_spoke) | Option to enable true and Disable false. | `string` | `"false"` | no |
| <a name="input_enable_traffic_threat_log"></a> [enable\_traffic\_threat\_log](#input\_enable\_traffic\_threat\_log) | Enable Traffic & Threat Log on Network Firewall. | `bool` | n/a | yes |
| <a name="input_enable_vpn_on_environment"></a> [enable\_vpn\_on\_environment](#input\_enable\_vpn\_on\_environment) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT. | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_igw_hub_check"></a> [igw\_hub\_check](#input\_igw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_ipsec_connection_static_routes"></a> [ipsec\_connection\_static\_routes](#input\_ipsec\_connection\_static\_routes) | ----------------------------------------------------------------------------- VPN Variables ----------------------------------------------------------------------------- | `list(string)` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_log_group_id"></a> [log\_group\_id](#input\_log\_group\_id) | Log Group OCID. | `string` | n/a | yes |
| <a name="input_nat_gw_hub_check"></a> [nat\_gw\_hub\_check](#input\_nat\_gw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_nat_gw_spoke_check"></a> [nat\_gw\_spoke\_check](#input\_nat\_gw\_spoke\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | Network Compartment OCID | `string` | n/a | yes |
| <a name="input_nfw_instance_name"></a> [nfw\_instance\_name](#input\_nfw\_instance\_name) | Network Firewall Instance Name. | `string` | n/a | yes |
| <a name="input_nfw_instance_policy"></a> [nfw\_instance\_policy](#input\_nfw\_instance\_policy) | Network Firewall Policy Name. | `string` | n/a | yes |
| <a name="input_nfw_subnet_type"></a> [nfw\_subnet\_type](#input\_nfw\_subnet\_type) | Network Firewall Subnet Type : Public or Private Subnet. | `string` | n/a | yes |
| <a name="input_nfw_use_existing_network"></a> [nfw\_use\_existing\_network](#input\_nfw\_use\_existing\_network) | Use Existing VCN instead of Network Firewall. | `bool` | n/a | yes |
| <a name="input_private_spoke_subnet_app_cidr_block"></a> [private\_spoke\_subnet\_app\_cidr\_block](#input\_private\_spoke\_subnet\_app\_cidr\_block) | Spoke: Private Subnet App CIDR Block-1. | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_db_cidr_block"></a> [private\_spoke\_subnet\_db\_cidr\_block](#input\_private\_spoke\_subnet\_db\_cidr\_block) | Spoke: Private Subnet DB CIDR Block-1. | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_web_cidr_block"></a> [private\_spoke\_subnet\_web\_cidr\_block](#input\_private\_spoke\_subnet\_web\_cidr\_block) | Spoke: Private Subnet Web CIDR Block. | `string` | n/a | yes |
| <a name="input_private_subnet_cidr_block"></a> [private\_subnet\_cidr\_block](#input\_private\_subnet\_cidr\_block) | Hub: Private Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_public_subnet_cidr_block"></a> [public\_subnet\_cidr\_block](#input\_public\_subnet\_cidr\_block) | Hub: Public Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_service_gw_hub_check"></a> [service\_gw\_hub\_check](#input\_service\_gw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_service_gw_spoke_check"></a> [service\_gw\_spoke\_check](#input\_service\_gw\_spoke\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_spoke_vcn_cidr"></a> [spoke\_vcn\_cidr](#input\_spoke\_vcn\_cidr) | Spoke:VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_cidr_block"></a> [vcn\_cidr\_block](#input\_vcn\_cidr\_block) | VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_compartment_id"></a> [workload\_compartment\_id](#input\_workload\_compartment\_id) | WorkLoad Compartment OCID | `string` | n/a | yes |
| <a name="input_workload_compartment_name"></a> [workload\_compartment\_name](#input\_workload\_compartment\_name) | WorkLoad Compartment Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drg_id"></a> [drg\_id](#output\_drg\_id) | DRG OCID ID. |
| <a name="output_spoke_app_subnet_ocid"></a> [spoke\_app\_subnet\_ocid](#output\_spoke\_app\_subnet\_ocid) | Spoke App Subnet OCID. |
| <a name="output_spoke_db_subnet_ocid"></a> [spoke\_db\_subnet\_ocid](#output\_spoke\_db\_subnet\_ocid) | Spoke DB Subnet OCID. |
| <a name="output_spoke_web_subnet_ocid"></a> [spoke\_web\_subnet\_ocid](#output\_spoke\_web\_subnet\_ocid) | Spoke Web Subnet OCID. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Hub & Spoke Subnet. |
| <a name="output_vcn"></a> [vcn](#output\_vcn) | Hub VCN OCID ID. |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.