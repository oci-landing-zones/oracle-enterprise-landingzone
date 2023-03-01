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
| [oci_logging_log.service_log](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/logging_log) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_log_display_name"></a> [log\_display\_name](#input\_log\_display\_name) | The display name of service log | `string` | n/a | yes |
| <a name="input_log_group_id"></a> [log\_group\_id](#input\_log\_group\_id) | The OCID of a log group to work with. | `string` | n/a | yes |
| <a name="input_log_source_category"></a> [log\_source\_category](#input\_log\_source\_category) | Log object category. | `string` | n/a | yes |
| <a name="input_log_source_service"></a> [log\_source\_service](#input\_log\_source\_service) | Service generating log. | `string` | n/a | yes |
| <a name="input_log_source_type"></a> [log\_source\_type](#input\_log\_source\_type) | The log source type. | `string` | n/a | yes |
| <a name="input_log_type"></a> [log\_type](#input\_log\_type) | The logType that the log object is for, whether custom or service. | `string` | n/a | yes |
| <a name="input_service_log_map"></a> [service\_log\_map](#input\_service\_log\_map) | n/a | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    