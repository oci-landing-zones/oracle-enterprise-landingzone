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
| <a name="module_fastconnect"></a> [fastconnect](#module\_fastconnect) | ../../modules/fastconnect | n/a |
| <a name="module_ipsec"></a> [ipsec](#module\_ipsec) | ../../modules/ipsec | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_core_drg_attachment_management.drg_rpc_attachment_nonprod](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_drg_attachment_management) | resource |
| [oci_core_drg_attachment_management.drg_rpc_attachment_prod](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_drg_attachment_management) | resource |
| [oci_core_remote_peering_connection.remote_peering_connection](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_remote_peering_connection) | resource |
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_cust_tunnela_ip"></a> [bgp\_cust\_tunnela\_ip](#input\_bgp\_cust\_tunnela\_ip) | n/a | `string` | n/a | yes |
| <a name="input_bgp_md5auth_key"></a> [bgp\_md5auth\_key](#input\_bgp\_md5auth\_key) | n/a | `string` | n/a | yes |
| <a name="input_bgp_oci_tunnela_ip"></a> [bgp\_oci\_tunnela\_ip](#input\_bgp\_oci\_tunnela\_ip) | n/a | `string` | n/a | yes |
| <a name="input_cpe_display_name"></a> [cpe\_display\_name](#input\_cpe\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_cpe_ip_address"></a> [cpe\_ip\_address](#input\_cpe\_ip\_address) | Customer Premises Equipment (CPE) IP address | `string` | n/a | yes |
| <a name="input_cpe_vendor"></a> [cpe\_vendor](#input\_cpe\_vendor) | n/a | `number` | n/a | yes |
| <a name="input_customer_bgp_asn"></a> [customer\_bgp\_asn](#input\_customer\_bgp\_asn) | n/a | `string` | n/a | yes |
| <a name="input_customer_primary_bgp_peering_ip"></a> [customer\_primary\_bgp\_peering\_ip](#input\_customer\_primary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_customer_secondary_bgp_peering_ip"></a> [customer\_secondary\_bgp\_peering\_ip](#input\_customer\_secondary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | n/a | `string` | n/a | yes |
| <a name="input_drg_route_table_rpc_id"></a> [drg\_route\_table\_rpc\_id](#input\_drg\_route\_table\_rpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_drg_route_table_vc_id"></a> [drg\_route\_table\_vc\_id](#input\_drg\_route\_table\_vc\_id) | n/a | `string` | n/a | yes |
| <a name="input_enable_fastconnect_on_environment"></a> [enable\_fastconnect\_on\_environment](#input\_enable\_fastconnect\_on\_environment) | n/a | `bool` | n/a | yes |
| <a name="input_enable_vpn_on_environment"></a> [enable\_vpn\_on\_environment](#input\_enable\_vpn\_on\_environment) | VPN Variables | `bool` | n/a | yes |
| <a name="input_enable_vpn_or_fastconnect"></a> [enable\_vpn\_or\_fastconnect](#input\_enable\_vpn\_or\_fastconnect) | Option to enable VPN or FASTCONNECT service. Options are NONE, VPN, FASTCONNECT. | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_fastconnect_provider"></a> [fastconnect\_provider](#input\_fastconnect\_provider) | Fastconnect Variables | `string` | n/a | yes |
| <a name="input_fastconnect_routing_policy"></a> [fastconnect\_routing\_policy](#input\_fastconnect\_routing\_policy) | n/a | `list(string)` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_ipsec_connection_static_routes"></a> [ipsec\_connection\_static\_routes](#input\_ipsec\_connection\_static\_routes) | n/a | `list(string)` | n/a | yes |
| <a name="input_ipsec_display_name"></a> [ipsec\_display\_name](#input\_ipsec\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_oracle_primary_bgp_peering_ip"></a> [oracle\_primary\_bgp\_peering\_ip](#input\_oracle\_primary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_oracle_secondary_bgp_peering_ip"></a> [oracle\_secondary\_bgp\_peering\_ip](#input\_oracle\_secondary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_provider_service_key_name"></a> [provider\_service\_key\_name](#input\_provider\_service\_key\_name) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_region_key"></a> [region\_key](#input\_region\_key) | n/a | `string` | n/a | yes |
| <a name="input_remote_peering_connection_peer_id"></a> [remote\_peering\_connection\_peer\_id](#input\_remote\_peering\_connection\_peer\_id) | n/a | `string` | `null` | no |
| <a name="input_remote_peering_connection_peer_region_name"></a> [remote\_peering\_connection\_peer\_region\_name](#input\_remote\_peering\_connection\_peer\_region\_name) | n/a | `string` | `null` | no |
| <a name="input_routing"></a> [routing](#input\_routing) | n/a | `string` | n/a | yes |
| <a name="input_shared_secret"></a> [shared\_secret](#input\_shared\_secret) | n/a | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_tunnel_a_display_name"></a> [tunnel\_a\_display\_name](#input\_tunnel\_a\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_tunnel_b_display_name"></a> [tunnel\_b\_display\_name](#input\_tunnel\_b\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_bandwidth_shape"></a> [virtual\_circuit\_bandwidth\_shape](#input\_virtual\_circuit\_bandwidth\_shape) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_customer_asn"></a> [virtual\_circuit\_customer\_asn](#input\_virtual\_circuit\_customer\_asn) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_display_name"></a> [virtual\_circuit\_display\_name](#input\_virtual\_circuit\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_is_bfd_enabled"></a> [virtual\_circuit\_is\_bfd\_enabled](#input\_virtual\_circuit\_is\_bfd\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_virtual_circuit_type"></a> [virtual\_circuit\_type](#input\_virtual\_circuit\_type) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rpc_id"></a> [rpc\_id](#output\_rpc\_id) | n/a |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.