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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment to contain the route table. | `string` | n/a | yes |
| <a name="input_route_rules"></a> [route\_rules](#input\_route\_rules) | The collection of rules for routing destination IPs to network devices. | `map(any)` | n/a | yes |
| <a name="input_route_table_display_name"></a> [route\_table\_display\_name](#input\_route\_table\_display\_name) | The display name of route table | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | The OCID of the VCN the route table belongs to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | The OCID of the route table |
<!-- END_TF_DOCS -->