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
| [oci_core_service_gateway.service_gateway_all_svcs](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_service_gateway) | resource |
| [oci_core_services.service_gateway_all_oci_services](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | The OCID of the compartment to contain the VCN. | `string` | n/a | yes |
| <a name="input_service_gateway_display_name"></a> [service\_gateway\_display\_name](#input\_service\_gateway\_display\_name) | Service Gateway Display Name. | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | The VCN OCID Value | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_gw_id"></a> [service\_gw\_id](#output\_service\_gw\_id) | Service Gateway OCID. |
<!-- END_TF_DOCS -->