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
| <a name="module_workload-spoke-nat-gateway"></a> [workload-spoke-nat-gateway](#module\_workload-spoke-nat-gateway) | ../../modules/nat-gateway | n/a |
| <a name="module_workload-spoke-service-gateway"></a> [workload-spoke-service-gateway](#module\_workload-spoke-service-gateway) | ../../modules/service-gateway | n/a |
| <a name="module_workload_spoke_route_table"></a> [workload\_spoke\_route\_table](#module\_workload\_spoke\_route\_table) | ../../modules/route-table | n/a |
| <a name="module_workload_spoke_security_list"></a> [workload\_spoke\_security\_list](#module\_workload\_spoke\_security\_list) | ../../modules/security-list | n/a |
| <a name="module_workload_spoke_subnet"></a> [workload\_spoke\_subnet](#module\_workload\_spoke\_subnet) | ../../modules/subnet | n/a |
| <a name="module_workload_spoke_vcn"></a> [workload\_spoke\_vcn](#module\_workload\_spoke\_vcn) | ../../modules/vcn | n/a |
| <a name="module_workload_spoke_vcn_drg_attachment"></a> [workload\_spoke\_vcn\_drg\_attachment](#module\_workload\_spoke\_vcn\_drg\_attachment) | ../../modules/drg-attachment | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_core_services.service_gateway](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/core_services) | data source |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_onprem_ip_cidr"></a> [customer\_onprem\_ip\_cidr](#input\_customer\_onprem\_ip\_cidr) | n/a | `any` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | n/a | `string` | n/a | yes |
| <a name="input_enable_nat_gateway_spoke"></a> [enable\_nat\_gateway\_spoke](#input\_enable\_nat\_gateway\_spoke) | n/a | `bool` | n/a | yes |
| <a name="input_enable_network_firewall"></a> [enable\_network\_firewall](#input\_enable\_network\_firewall) | Enable Network Firewall in Enviornment. | `bool` | `"false"` | no |
| <a name="input_enable_service_gateway_spoke"></a> [enable\_service\_gateway\_spoke](#input\_enable\_service\_gateway\_spoke) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpn_on_environment"></a> [enable\_vpn\_on\_environment](#input\_enable\_vpn\_on\_environment) | n/a | `any` | n/a | yes |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | n/a | `any` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_hub_private_subnet_cidr_block"></a> [hub\_private\_subnet\_cidr\_block](#input\_hub\_private\_subnet\_cidr\_block) | n/a | `string` | n/a | yes |
| <a name="input_hub_public_subnet_cidr_block"></a> [hub\_public\_subnet\_cidr\_block](#input\_hub\_public\_subnet\_cidr\_block) | n/a | `string` | n/a | yes |
| <a name="input_ipsec_connection_static_routes"></a> [ipsec\_connection\_static\_routes](#input\_ipsec\_connection\_static\_routes) | n/a | `any` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_nat_gateway_display_name"></a> [nat\_gateway\_display\_name](#input\_nat\_gateway\_display\_name) | (Updatable) Name of NAT Gateway. Does not have to be unique. | `string` | n/a | yes |
| <a name="input_nat_gw_spoke_check"></a> [nat\_gw\_spoke\_check](#input\_nat\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_nfw_ip_address"></a> [nfw\_ip\_address](#input\_nfw\_ip\_address) | Network Firewall Forwarding IP. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_route_table_display_name"></a> [route\_table\_display\_name](#input\_route\_table\_display\_name) | Workload Expansion Spoke Route Table Name Disply Name. | `string` | n/a | yes |
| <a name="input_security_list_display_name"></a> [security\_list\_display\_name](#input\_security\_list\_display\_name) | Workload Expansion Spoke Security List Name Disly Name. | `string` | n/a | yes |
| <a name="input_service_gateway_display_name"></a> [service\_gateway\_display\_name](#input\_service\_gateway\_display\_name) | (Updatable) Name of Service Gateway. Does not have to be unique. | `string` | n/a | yes |
| <a name="input_service_gw_spoke_check"></a> [service\_gw\_spoke\_check](#input\_service\_gw\_spoke\_check) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name) | Workload Expansion Spoke VCN Display Name | `string` | n/a | yes |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | n/a | yes |
| <a name="input_workload_compartment_id"></a> [workload\_compartment\_id](#input\_workload\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_workload_compartment_name"></a> [workload\_compartment\_name](#input\_workload\_compartment\_name) | The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>. | `string` | `"OCI-ELZ-Workload1"` | no |
| <a name="input_workload_private_spoke_subnet_app_cidr_block"></a> [workload\_private\_spoke\_subnet\_app\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_app\_cidr\_block) | Workload Enivornment Spoke VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_app_display_name"></a> [workload\_private\_spoke\_subnet\_app\_display\_name](#input\_workload\_private\_spoke\_subnet\_app\_display\_name) | Workload Expansion Spoke App Subnet Display Name. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_app_dns_label"></a> [workload\_private\_spoke\_subnet\_app\_dns\_label](#input\_workload\_private\_spoke\_subnet\_app\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_db_cidr_block"></a> [workload\_private\_spoke\_subnet\_db\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_db\_cidr\_block) | Workload Enivornment Spoke VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_db_display_name"></a> [workload\_private\_spoke\_subnet\_db\_display\_name](#input\_workload\_private\_spoke\_subnet\_db\_display\_name) | Workload Expansion Spoke Db Subnet Display Name. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_db_dns_label"></a> [workload\_private\_spoke\_subnet\_db\_dns\_label](#input\_workload\_private\_spoke\_subnet\_db\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_web_cidr_block"></a> [workload\_private\_spoke\_subnet\_web\_cidr\_block](#input\_workload\_private\_spoke\_subnet\_web\_cidr\_block) | Workload Enivornment Spoke VCN CIDR Block. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_web_display_name"></a> [workload\_private\_spoke\_subnet\_web\_display\_name](#input\_workload\_private\_spoke\_subnet\_web\_display\_name) | Workload Expansion Spoke Web Subnet Display Name. | `string` | n/a | yes |
| <a name="input_workload_private_spoke_subnet_web_dns_label"></a> [workload\_private\_spoke\_subnet\_web\_dns\_label](#input\_workload\_private\_spoke\_subnet\_web\_dns\_label) | A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet | `string` | n/a | yes |
| <a name="input_workload_spoke_vcn_cidr"></a> [workload\_spoke\_vcn\_cidr](#input\_workload\_spoke\_vcn\_cidr) | The list of IPv4 CIDR blocks the VCN will use. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_spoke_app_subnet_ocid"></a> [spoke\_app\_subnet\_ocid](#output\_spoke\_app\_subnet\_ocid) | Spoke App Subnet OCID. |
| <a name="output_spoke_db_subnet_ocid"></a> [spoke\_db\_subnet\_ocid](#output\_spoke\_db\_subnet\_ocid) | Spoke DB Subnet OCID. |
| <a name="output_spoke_web_subnet_ocid"></a> [spoke\_web\_subnet\_ocid](#output\_spoke\_web\_subnet\_ocid) | Spoke Web Subnet OCID. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The Spoke Subnet OCID |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.