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
| [oci_core_nat_gateway.nat_gw](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway) | resource |
| [oci_core_service_gateway.service_gw](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_service_gateway) | resource |
| [oci_core_services.service_gateway_all_oci_services](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | n/a | `bool` | n/a | yes |
| <a name="input_create_service_gateway"></a> [create\_service\_gateway](#input\_create\_service\_gateway) | n/a | `bool` | n/a | yes |
| <a name="input_nat_gateway_display_name"></a> [nat\_gateway\_display\_name](#input\_nat\_gateway\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_nat_network_compartment_id"></a> [nat\_network\_compartment\_id](#input\_nat\_network\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_nat_vcn_id"></a> [nat\_vcn\_id](#input\_nat\_vcn\_id) | n/a | `string` | n/a | yes |
| <a name="input_service_gateway_display_name"></a> [service\_gateway\_display\_name](#input\_service\_gateway\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_sgw_network_compartment_id"></a> [sgw\_network\_compartment\_id](#input\_sgw\_network\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_sgw_vcn_id"></a> [sgw\_vcn\_id](#input\_sgw\_vcn\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gw_id"></a> [internet\_gw\_id](#output\_internet\_gw\_id) | Internet Gateway OCID Value. |
| <a name="output_nat_gw_id"></a> [nat\_gw\_id](#output\_nat\_gw\_id) | NAT Gateway OCID Value. |
| <a name="output_service_gw_id"></a> [service\_gw\_id](#output\_service\_gw\_id) | Service Gateway OCID Value. |
<!-- END_TF_DOCS -->