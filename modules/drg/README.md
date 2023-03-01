## Summary
Terraform module for managing a single Dynamic Routing Gateway 
and associated routing resources - including drg, attachments, 
route distributions, and drg route tables.

## Dependencies 
* VCN
* Route-Table

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
| [oci_core_drg.drg](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg) | resource |
| [oci_core_drg_attachment.drg_vcn_attachment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment) | resource |
| [oci_core_drg_route_distribution.route_distribution](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_distribution) | resource |
| [oci_core_drg_route_distribution_statement.route_distribution_statement](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_distribution_statement) | resource |
| [oci_core_drg_route_table.route_table](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_table) | resource |
| [oci_core_drg_route_table_route_rule.drg_route_table_route_rule](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_route_table_route_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | compartment id where to create all resources | `string` | n/a | yes |
| <a name="input_drg_display_name"></a> [drg\_display\_name](#input\_drg\_display\_name) | (Updatable) Name of Dynamic Routing Gateway. Does not have to be unique. | `string` | n/a | yes |
| <a name="input_drg_route_table_map"></a> [drg\_route\_table\_map](#input\_drg\_route\_table\_map) | The route table used by the DRG attachment. | `map(any)` | `null` | no |
| <a name="input_drg_vcn_attachments"></a> [drg\_vcn\_attachments](#input\_drg\_vcn\_attachments) | The network resource attached to the DRG | `map(any)` | `null` | no |
| <a name="input_route_distribution_map"></a> [route\_distribution\_map](#input\_route\_distribution\_map) | The route table used by the DRG attachment. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drg_attachment_all_attributes"></a> [drg\_attachment\_all\_attributes](#output\_drg\_attachment\_all\_attributes) | all attributes related to drg attachment |
| <a name="output_drg_id"></a> [drg\_id](#output\_drg\_id) | id of drg if it is created |
| <a name="output_drg_route_tables"></a> [drg\_route\_tables](#output\_drg\_route\_tables) | n/a |
<!-- END_TF_DOCS -->    