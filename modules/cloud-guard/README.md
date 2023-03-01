## Summary
Terraform module for OCI Cloud Guard service.
That detects misconfigured resources, insecure activity
across tenants/compartments, and malicious threat activities and
provides security administrators with the visibility to triage
and resolve cloud security issues.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci.home_region"></a> [oci.home\_region](#provider\_oci.home\_region) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_cloud_guard_cloud_guard_configuration.cloud_guard_configuration](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/cloud_guard_cloud_guard_configuration) | resource |
| [oci_cloud_guard_target.cloud_guard_target](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/cloud_guard_target) | resource |
| [oci_cloud_guard_detector_recipes.activity_detector_recipe](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/cloud_guard_detector_recipes) | data source |
| [oci_cloud_guard_detector_recipes.configuration_detector_recipe](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/cloud_guard_detector_recipes) | data source |
| [oci_cloud_guard_detector_recipes.threat_detector_recipe](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/cloud_guard_detector_recipes) | data source |
| [oci_cloud_guard_responder_recipes.responder_recipe](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/cloud_guard_responder_recipes) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activity_detector_recipe_display_name"></a> [activity\_detector\_recipe\_display\_name](#input\_activity\_detector\_recipe\_display\_name) | The display name of activity detector recipe. | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment in which to list resources. | `string` | n/a | yes |
| <a name="input_configuration_detector_recipe_display_name"></a> [configuration\_detector\_recipe\_display\_name](#input\_configuration\_detector\_recipe\_display\_name) | The display name of configuration detector recipe. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The target description. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of cloud guard target | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The reporting region value. | `string` | n/a | yes |
| <a name="input_responder_recipe_display_name"></a> [responder\_recipe\_display\_name](#input\_responder\_recipe\_display\_name) | The display name of responder recipe. | `string` | n/a | yes |
| <a name="input_status"></a> [status](#input\_status) | Status of Cloud Guard Tenant | `string` | n/a | yes |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | Resource ID which the target uses to monitor. | `string` | n/a | yes |
| <a name="input_target_resource_type"></a> [target\_resource\_type](#input\_target\_resource\_type) | The type of targets. | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_threat_detector_recipe_display_name"></a> [threat\_detector\_recipe\_display\_name](#input\_threat\_detector\_recipe\_display\_name) | The display name of threat detector recipe. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    