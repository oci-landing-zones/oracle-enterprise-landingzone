## Summary
Terraform module for Service Connector.
Service Connector Hub is a cloud message bus
platform that offers a single pane of glass for describing,
executing, and monitoring interactions when moving data between
Oracle Cloud Infrastructure services.

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
| [oci_sch_service_connector.service_connector](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/sch_service_connector) | resource |
| [oci_objectstorage_namespace.ns](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/objectstorage_namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the comparment to create the service connector in. | `string` | n/a | yes |
| <a name="input_cursor_kind"></a> [cursor\_kind](#input\_cursor\_kind) | The cursor type discriminator. | `string` | `""` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of service connector created | `string` | n/a | yes |
| <a name="input_log_group_id"></a> [log\_group\_id](#input\_log\_group\_id) | The OCID of the log group. | `string` | `""` | no |
| <a name="input_source_compartment_id"></a> [source\_compartment\_id](#input\_source\_compartment\_id) | The OCID of the compartment containing the log source. | `string` | n/a | yes |
| <a name="input_source_kind"></a> [source\_kind](#input\_source\_kind) | The source type discriminator. | `string` | n/a | yes |
| <a name="input_stream_id"></a> [stream\_id](#input\_stream\_id) | The OCID of the stream. | `string` | `""` | no |
| <a name="input_target_bucket"></a> [target\_bucket](#input\_target\_bucket) | The name of the target bucket. | `string` | n/a | yes |
| <a name="input_target_kind"></a> [target\_kind](#input\_target\_kind) | The target type discriminator. | `string` | `"objectStorage"` | no |
| <a name="input_target_namespace"></a> [target\_namespace](#input\_target\_namespace) | The namespace of target bucket | `string` | `""` | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | Tenancy LZ is created in. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    