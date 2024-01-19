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
| <a name="module_budget"></a> [budget](#module\_budget) | ../../modules/budget | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_alert_rule_message"></a> [budget\_alert\_rule\_message](#input\_budget\_alert\_rule\_message) | The alert message for budget alerts. | `string` | n/a | yes |
| <a name="input_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#input\_budget\_alert\_rule\_recipients) | The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon | `string` | n/a | yes |
| <a name="input_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#input\_budget\_alert\_rule\_threshold) | The target for the budget | `string` | n/a | yes |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | The amount of the budget expressed as a whole number in the currency of the customer's rate card. | `string` | n/a | yes |
| <a name="input_budget_compartment_id"></a> [budget\_compartment\_id](#input\_budget\_compartment\_id) | The ocid of compartment to provision resources | `string` | n/a | yes |
| <a name="input_budget_description"></a> [budget\_description](#input\_budget\_description) | n/a | `string` | n/a | yes |
| <a name="input_budget_display_name"></a> [budget\_display\_name](#input\_budget\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_budget_target"></a> [budget\_target](#input\_budget\_target) | The compartment ocid for the budget | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budget"></a> [budget](#output\_budget) | n/a |
| <a name="output_budget_alert_rule"></a> [budget\_alert\_rule](#output\_budget\_alert\_rule) | n/a |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.