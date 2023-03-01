## Summary
Terraform module for Route Table creation.

## Dependencies 
* VCN

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
| [oci_core_route_table_attachment.oci_core_route_table_attachment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment to contain the route table. | `string` | n/a | yes |
| <a name="input_default_route_table_id"></a> [default\_route\_table\_id](#input\_default\_route\_table\_id) | n/a | `string` | `"The OCID of default route table"` | no |
| <a name="input_is_default"></a> [is\_default](#input\_is\_default) | Option use default route table | `bool` | `false` | no |
| <a name="input_route_rules"></a> [route\_rules](#input\_route\_rules) | The collection of rules for routing destination IPs to network devices. | `map(any)` | n/a | yes |
| <a name="input_route_table_display_name"></a> [route\_table\_display\_name](#input\_route\_table\_display\_name) | The display name of route table | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The OCID of the subnet. | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet. | `string` | `""` | no |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | The OCID of the VCN the route table belongs to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The OCID of the route table |
<!-- END_TF_DOCS -->