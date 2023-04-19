<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_tag.tag](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_tag) | resource |
| [oci_identity_tag_default.tag_default](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_tag_default) | resource |
| [oci_identity_tag_namespace.tag_namespace](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_tag_namespace) | resource |
| [time_sleep.tag_creation_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment. | `string` | n/a | yes |
| <a name="input_is_namespace_retired"></a> [is\_namespace\_retired](#input\_is\_namespace\_retired) | Whether the tag namespace is retired. | `bool` | `false` | no |
| <a name="input_tag_default_map"></a> [tag\_default\_map](#input\_tag\_default\_map) | n/a | `any` | n/a | yes |
| <a name="input_tag_map"></a> [tag\_map](#input\_tag\_map) | n/a | `any` | n/a | yes |
| <a name="input_tag_namespace_description"></a> [tag\_namespace\_description](#input\_tag\_namespace\_description) | The description of the tag namespace. | `string` | n/a | yes |
| <a name="input_tag_namespace_name"></a> [tag\_namespace\_name](#input\_tag\_namespace\_name) | The name of the tag namespace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | Tag NameSpace OCID |
| <a name="output_tag"></a> [tag](#output\_tag) | Tag Values |
| <a name="output_tag_default"></a> [tag\_default](#output\_tag\_default) | Tag Default Values |
<!-- END_TF_DOCS -->    