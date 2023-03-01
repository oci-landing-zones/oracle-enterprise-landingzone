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
| [oci_vulnerability_scanning_host_scan_recipe.vss_host_scan_recipe](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vulnerability_scanning_host_scan_recipe) | resource |
| [oci_vulnerability_scanning_host_scan_target.vss_host_scan_target](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vulnerability_scanning_host_scan_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_cis_benchmark_settings_scan_level"></a> [agent\_cis\_benchmark\_settings\_scan\_level](#input\_agent\_cis\_benchmark\_settings\_scan\_level) | Agent benchmarking settings scan level | `string` | n/a | yes |
| <a name="input_host_scan_recipe_agent_settings_agent_configuration_vendor"></a> [host\_scan\_recipe\_agent\_settings\_agent\_configuration\_vendor](#input\_host\_scan\_recipe\_agent\_settings\_agent\_configuration\_vendor) | Vulnerability scanning service agent vendor | `string` | `"OCI"` | no |
| <a name="input_host_scan_recipe_agent_settings_scan_level"></a> [host\_scan\_recipe\_agent\_settings\_scan\_level](#input\_host\_scan\_recipe\_agent\_settings\_scan\_level) | Vulnerability scanning service agent scan level | `string` | n/a | yes |
| <a name="input_host_scan_recipe_display_name"></a> [host\_scan\_recipe\_display\_name](#input\_host\_scan\_recipe\_display\_name) | Vulnerability scanning service display name | `string` | n/a | yes |
| <a name="input_host_scan_recipe_port_settings_scan_level"></a> [host\_scan\_recipe\_port\_settings\_scan\_level](#input\_host\_scan\_recipe\_port\_settings\_scan\_level) | Vulnerability scanning service port scan level | `string` | n/a | yes |
| <a name="input_host_scan_target_description"></a> [host\_scan\_target\_description](#input\_host\_scan\_target\_description) | Vulnerability scanning service target description | `string` | `"Vulnerability scanning service scan target"` | no |
| <a name="input_host_scan_target_display_name"></a> [host\_scan\_target\_display\_name](#input\_host\_scan\_target\_display\_name) | Vulnerability scanning service target display name | `string` | n/a | yes |
| <a name="input_recipe_compartment_ocid"></a> [recipe\_compartment\_ocid](#input\_recipe\_compartment\_ocid) | the compartment ocid | `string` | n/a | yes |
| <a name="input_target_compartment_ocid"></a> [target\_compartment\_ocid](#input\_target\_compartment\_ocid) | the compartment ocid of the vss target | `string` | n/a | yes |
| <a name="input_vss_scan_schedule"></a> [vss\_scan\_schedule](#input\_vss\_scan\_schedule) | Vulnerability scanning service scan schedule | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    