<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.groups](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_names"></a> [group\_names](#input\_group\_names) | The list of user group names. | `list(string)` | n/a | yes |
| <a name="input_identity_domain_id"></a> [identity\_domain\_id](#input\_identity\_domain\_id) | the OCID of identity domain | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->