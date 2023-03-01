## Summary

Terraform module for OCI IPSec creation.

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
| [oci_core_cpe.oci-ipsec-cpe](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_cpe) | resource |
| [oci_core_ipsec.oci-ipsec-connection](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_ipsec) | resource |
| [oci_core_ipsec_connection_tunnel_management.oci-ipsec-connection-tunnel-management-a](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_ipsec_connection_tunnel_management) | resource |
| [oci_core_ipsec_connection_tunnel_management.oci-ipsec-connection-tunnel-management-b](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_ipsec_connection_tunnel_management) | resource |
| [oci_core_cpe_device_shape.oci-ipsec-cpe-device-shape](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_cpe_device_shape) | data source |
| [oci_core_cpe_device_shapes.cpe_device_shapes](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_cpe_device_shapes) | data source |
| [oci_core_ipsec_connection_tunnel.oci-ipsec-connection-tunnel-a](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_ipsec_connection_tunnel) | data source |
| [oci_core_ipsec_connection_tunnel.oci-ipsec-connection-tunnel-b](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_ipsec_connection_tunnel) | data source |
| [oci_core_ipsec_connection_tunnels.oci-ipsec-connection-tunnels](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_ipsec_connection_tunnels) | data source |
| [oci_core_ipsec_connections.oci-ipsec-connections](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_ipsec_connections) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_cust_tunnela_ip"></a> [bgp\_cust\_tunnela\_ip](#input\_bgp\_cust\_tunnela\_ip) | n/a | `any` | n/a | yes |
| <a name="input_bgp_oci_tunnela_ip"></a> [bgp\_oci\_tunnela\_ip](#input\_bgp\_oci\_tunnela\_ip) | n/a | `any` | n/a | yes |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | n/a | `string` | n/a | yes |
| <a name="input_cpe_display_name"></a> [cpe\_display\_name](#input\_cpe\_display\_name) | Customer Premises Equipment IP address | `string` | n/a | yes |
| <a name="input_cpe_ip_address"></a> [cpe\_ip\_address](#input\_cpe\_ip\_address) | Customer Premises Equipment IP address | `string` | n/a | yes |
| <a name="input_cpe_vendor"></a> [cpe\_vendor](#input\_cpe\_vendor) | n/a | `number` | n/a | yes |
| <a name="input_customer_bgp_asn"></a> [customer\_bgp\_asn](#input\_customer\_bgp\_asn) | n/a | `any` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | n/a | `string` | n/a | yes |
| <a name="input_ipsec_display_name"></a> [ipsec\_display\_name](#input\_ipsec\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | n/a | `string` | n/a | yes |
| <a name="input_shared_secret"></a> [shared\_secret](#input\_shared\_secret) | n/a | `any` | n/a | yes |
| <a name="input_static_routes"></a> [static\_routes](#input\_static\_routes) | n/a | `list(string)` | n/a | yes |
| <a name="input_tunnel_a_display_name"></a> [tunnel\_a\_display\_name](#input\_tunnel\_a\_display\_name) | n/a | `any` | n/a | yes |
| <a name="input_tunnel_b_display_name"></a> [tunnel\_b\_display\_name](#input\_tunnel\_b\_display\_name) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    