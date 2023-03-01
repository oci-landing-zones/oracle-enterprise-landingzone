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
| [oci_core_nat_gateway.OCI-ELZ-NGW-P-HUB](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nat_gateway_display_name"></a> [nat\_gateway\_display\_name](#input\_nat\_gateway\_display\_name) | NAT Gateway Display Name. | `string` | n/a | yes |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | The OCID of the compartment to contain the VCN. | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | The VCN OCID Value | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gw_id"></a> [nat\_gw\_id](#output\_nat\_gw\_id) | NAT Gateway OCID. |
<!-- END_TF_DOCS -->