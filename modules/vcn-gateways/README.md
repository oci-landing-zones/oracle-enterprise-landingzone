## Summary
Terraform module for Service Gateways and route table.

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
| [oci_core_route_table.route_table](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table) | resource |
| [oci_core_service_gateway.sgw](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_service_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment to contain the service gateway. | `string` | n/a | yes |
| <a name="input_route_rules"></a> [route\_rules](#input\_route\_rules) | Route Rules. | `map(any)` | n/a | yes |
| <a name="input_route_table_display_name"></a> [route\_table\_display\_name](#input\_route\_table\_display\_name) | The display name of route table. | `string` | n/a | yes |
| <a name="input_service_id"></a> [service\_id](#input\_service\_id) | The OCID of the Service. | `string` | n/a | yes |
| <a name="input_sgw_display_name"></a> [sgw\_display\_name](#input\_sgw\_display\_name) | The display name of service gateway | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | The OCID of the VCN | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | The OCID of the route table |
| <a name="output_sgw_id"></a> [sgw\_id](#output\_sgw\_id) | The OCID of the service gateway |
<!-- END_TF_DOCS -->