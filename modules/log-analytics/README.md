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
| [oci_identity_policy.policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_log_analytics_log_analytics_log_group.log_analytics_log_group](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/log_analytics_log_analytics_log_group) | resource |
| [oci_sch_service_connector.service_connector](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/sch_service_connector) | resource |
| [oci_log_analytics_namespaces.logging_analytics_namespaces](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/log_analytics_namespaces) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The id of the compartment to place the resources. | `string` | n/a | yes |
| <a name="input_log_group_description"></a> [log\_group\_description](#input\_log\_group\_description) | The description of log group | `string` | n/a | yes |
| <a name="input_log_group_display_name"></a> [log\_group\_display\_name](#input\_log\_group\_display\_name) | The display name of log group | `string` | n/a | yes |
| <a name="input_service_connector_display_name"></a> [service\_connector\_display\_name](#input\_service\_connector\_display\_name) | The display name of the logging analytics service connector | `string` | n/a | yes |
| <a name="input_service_connector_source_compartment_id"></a> [service\_connector\_source\_compartment\_id](#input\_service\_connector\_source\_compartment\_id) | The compartment of the source log group for the logging analytics service connector | `string` | n/a | yes |
| <a name="input_service_connector_source_kind"></a> [service\_connector\_source\_kind](#input\_service\_connector\_source\_kind) | The kind of log source for the logging analytics service connector | `string` | n/a | yes |
| <a name="input_service_connector_source_log_group_id"></a> [service\_connector\_source\_log\_group\_id](#input\_service\_connector\_source\_log\_group\_id) | The log group id for the logging analytics service connector | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_id"></a> [log\_group\_id](#output\_log\_group\_id) | The OCID of log group created |
| <a name="output_service_connector_id"></a> [service\_connector\_id](#output\_service\_connector\_id) | n/a |
<!-- END_TF_DOCS -->    