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
| <a name="module_drg"></a> [drg](#module\_drg) | ../../modules/drg | n/a |
| <a name="module_hub_internet_gateway"></a> [hub\_internet\_gateway](#module\_hub\_internet\_gateway) | ../../modules/internet-gateway | n/a |
| <a name="module_nat-gateway-hub"></a> [nat-gateway-hub](#module\_nat-gateway-hub) | ../../modules/nat-gateway | n/a |
| <a name="module_service-gateway-hub"></a> [service-gateway-hub](#module\_service-gateway-hub) | ../../modules/service-gateway | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_core_default_security_list.hub_default_security_list_locked_down](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_default_security_list) | resource |
| [oci_core_route_table.hub_private_route_table](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_route_table) | resource |
| [oci_core_route_table.hub_public_route_table](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_route_table) | resource |
| [oci_core_security_list.security_list_hub](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_security_list) | resource |
| [oci_core_subnet.hub_private_subnet](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_subnet) | resource |
| [oci_core_subnet.hub_public_subnet](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_subnet) | resource |
| [oci_core_vcn.vcn_hub_network](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_vcn) | resource |
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_core_services.service_gateway](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/core_services) | data source |
| [oci_core_subnets.subnets](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/core_subnets) | data source |
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
| <a name="input_enable_service_gateway_hub"></a> [enable\_service\_gateway\_hub](#input\_enable\_service\_gateway\_hub) | Option to enable true and Disable false. | `string` | `"false"` | no |
| <a name="input_enable_vpn_on_environment"></a> [enable\_vpn\_on\_environment](#input\_enable\_vpn\_on\_environment) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT. | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_igw_hub_check"></a> [igw\_hub\_check](#input\_igw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_ipsec_connection_static_routes"></a> [ipsec\_connection\_static\_routes](#input\_ipsec\_connection\_static\_routes) | ----------------------------------------------------------------------------- Network Extension Variables ----------------------------------------------------------------------------- | `list(string)` | n/a | yes |
| <a name="input_nat_gw_hub_check"></a> [nat\_gw\_hub\_check](#input\_nat\_gw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | Network Compartment OCID | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_app_cidr_block"></a> [private\_spoke\_subnet\_app\_cidr\_block](#input\_private\_spoke\_subnet\_app\_cidr\_block) | Spoke: Private Subnet App CIDR Block-1. | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_db_cidr_block"></a> [private\_spoke\_subnet\_db\_cidr\_block](#input\_private\_spoke\_subnet\_db\_cidr\_block) | Spoke: Private Subnet DB CIDR Block-1. | `string` | n/a | yes |
| <a name="input_private_spoke_subnet_web_cidr_block"></a> [private\_spoke\_subnet\_web\_cidr\_block](#input\_private\_spoke\_subnet\_web\_cidr\_block) | Spoke: Private Subnet Web CIDR Block. | `string` | n/a | yes |
| <a name="input_private_subnet_cidr_block"></a> [private\_subnet\_cidr\_block](#input\_private\_subnet\_cidr\_block) | Hub: Private Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_public_subnet_cidr_block"></a> [public\_subnet\_cidr\_block](#input\_public\_subnet\_cidr\_block) | Hub: Public Subnet CIDR Block. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_service_gw_hub_check"></a> [service\_gw\_hub\_check](#input\_service\_gw\_hub\_check) | n/a | `list(string)` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_cidr_block"></a> [vcn\_cidr\_block](#input\_vcn\_cidr\_block) | VCN CIDR Block. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drg_id"></a> [drg\_id](#output\_drg\_id) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The subnet OCID |
| <a name="output_vcn_id"></a> [vcn\_id](#output\_vcn\_id) | n/a |
<!-- END_TF_DOCS -->