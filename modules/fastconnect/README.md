## Summary

Terraform module for OCI FastConnect creation.


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_core_drg_attachment_management.drg_vc_attachment_asn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment_management) | resource |
| [oci_core_drg_attachment_management.drg_vc_attachment_azure](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment_management) | resource |
| [oci_core_drg_attachment_management.drg_vc_attachment_no_asn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment_management) | resource |
| [oci_core_virtual_circuit.azure_fastconnect_virtual_circuit](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_virtual_circuit) | resource |
| [oci_core_virtual_circuit.fastconnect_asn_virtual_circuit](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_virtual_circuit) | resource |
| [oci_core_virtual_circuit.fastconnect_no_asn_virtual_circuit](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_virtual_circuit) | resource |
| [oci_core_fast_connect_provider_service.fast_connect_provider_service](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_fast_connect_provider_service) | data source |
| [oci_core_fast_connect_provider_services.fast_connect_provider_services](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_fast_connect_provider_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_md5auth_key"></a> [bgp\_md5auth\_key](#input\_bgp\_md5auth\_key) | n/a | `string` | n/a | yes |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | n/a | `string` | n/a | yes |
| <a name="input_customer_primary_bgp_peering_ip"></a> [customer\_primary\_bgp\_peering\_ip](#input\_customer\_primary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_customer_secondary_bgp_peering_ip"></a> [customer\_secondary\_bgp\_peering\_ip](#input\_customer\_secondary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | n/a | `string` | n/a | yes |
| <a name="input_drg_route_table_vc_id"></a> [drg\_route\_table\_vc\_id](#input\_drg\_route\_table\_vc\_id) | n/a | `string` | n/a | yes |
| <a name="input_fastconnect_asn_provider_list"></a> [fastconnect\_asn\_provider\_list](#input\_fastconnect\_asn\_provider\_list) | Providers that require customer asn | `string` | `"Megaport,QTS,C3ntro,Cologix,CoreSite,Digital Realty,EdgeConneX,Epsilon,Equinix,InterCloud,Lumen,Neutrona,OracleL2ItegDeployment,Zayo"` | no |
| <a name="input_fastconnect_no_asn_provider_list"></a> [fastconnect\_no\_asn\_provider\_list](#input\_fastconnect\_no\_asn\_provider\_list) | Providers that don't require customer asn or peering ip | `string` | `"AT&T,Verizon,BT,OMCS,OracleL3ItegDeployment,Orange"` | no |
| <a name="input_fastconnect_provider"></a> [fastconnect\_provider](#input\_fastconnect\_provider) | n/a | `string` | n/a | yes |
| <a name="input_fastconnect_routing_policy"></a> [fastconnect\_routing\_policy](#input\_fastconnect\_routing\_policy) | n/a | `list(string)` | n/a | yes |
| <a name="input_oracle_primary_bgp_peering_ip"></a> [oracle\_primary\_bgp\_peering\_ip](#input\_oracle\_primary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_oracle_secondary_bgp_peering_ip"></a> [oracle\_secondary\_bgp\_peering\_ip](#input\_oracle\_secondary\_bgp\_peering\_ip) | n/a | `string` | n/a | yes |
| <a name="input_provider_service_key_name"></a> [provider\_service\_key\_name](#input\_provider\_service\_key\_name) | n/a | `string` | n/a | yes |
| <a name="input_region_key"></a> [region\_key](#input\_region\_key) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_bandwidth_shape"></a> [virtual\_circuit\_bandwidth\_shape](#input\_virtual\_circuit\_bandwidth\_shape) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_customer_asn"></a> [virtual\_circuit\_customer\_asn](#input\_virtual\_circuit\_customer\_asn) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_display_name"></a> [virtual\_circuit\_display\_name](#input\_virtual\_circuit\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_virtual_circuit_is_bfd_enabled"></a> [virtual\_circuit\_is\_bfd\_enabled](#input\_virtual\_circuit\_is\_bfd\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_virtual_circuit_type"></a> [virtual\_circuit\_type](#input\_virtual\_circuit\_type) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    