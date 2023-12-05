<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_architecture_tag"></a> [architecture\_tag](#module\_architecture\_tag) | ../../modules/tag | n/a |
| <a name="module_elz_tagging"></a> [elz\_tagging](#module\_elz\_tagging) | ../../modules/tag | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cost_center_tagging"></a> [cost\_center\_tagging](#input\_cost\_center\_tagging) | Compartment Cost Center Tag. | `string` | n/a | yes |
| <a name="input_enable_tagging"></a> [enable\_tagging](#input\_enable\_tagging) | Set to true to enable Tagging. | `bool` | n/a | yes |
| <a name="input_environment_compartment_id"></a> [environment\_compartment\_id](#input\_environment\_compartment\_id) | The OCID of the compartment. | `string` | n/a | yes |
| <a name="input_environment_compartment_name"></a> [environment\_compartment\_name](#input\_environment\_compartment\_name) | The OCID of the compartment. | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_geo_location_tagging"></a> [geo\_location\_tagging](#input\_geo\_location\_tagging) | Compartment Geo Location Tag. | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | Set to true to enable Tagging. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.