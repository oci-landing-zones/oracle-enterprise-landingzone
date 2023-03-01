## Summary
Terraform module for OCI Log Group.
Log groups are logical containers for organizing logs. Logs must always be inside log groups.

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
| [oci_logging_log_group.log_group](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/logging_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment that the resource belongs to. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description for log group | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of log group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_id"></a> [log\_group\_id](#output\_log\_group\_id) | The OCID of the log group created |
<!-- END_TF_DOCS -->    
