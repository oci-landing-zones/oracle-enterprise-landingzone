## Summary

Terraform module for OCI Budget creation. 
Created budget and budget alert rule for a target compartment. 

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
| [oci_budget_alert_rule.oci_budget_rule](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/budget_alert_rule) | resource |
| [oci_budget_budget.oci_budget](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/budget_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_alert_rule_display_name"></a> [budget\_alert\_rule\_display\_name](#input\_budget\_alert\_rule\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_budget_alert_rule_message"></a> [budget\_alert\_rule\_message](#input\_budget\_alert\_rule\_message) | The alert message for budget alerts. | `string` | n/a | yes |
| <a name="input_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#input\_budget\_alert\_rule\_recipients) | The type of alert for the budget | `string` | n/a | yes |
| <a name="input_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#input\_budget\_alert\_rule\_threshold) | The target for the budget | `number` | n/a | yes |
| <a name="input_budget_alert_rule_threshold_type"></a> [budget\_alert\_rule\_threshold\_type](#input\_budget\_alert\_rule\_threshold\_type) | The threshold type for the budget | `string` | `"ABSOLUTE"` | no |
| <a name="input_budget_alert_rule_type"></a> [budget\_alert\_rule\_type](#input\_budget\_alert\_rule\_type) | The type of alert for the budget | `string` | `"ACTUAL"` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | The amount of the budget expressed as a whole number in the currency of the customer's rate card. | `string` | n/a | yes |
| <a name="input_budget_description"></a> [budget\_description](#input\_budget\_description) | n/a | `string` | n/a | yes |
| <a name="input_budget_display_name"></a> [budget\_display\_name](#input\_budget\_display\_name) | n/a | `string` | n/a | yes |
| <a name="input_budget_reset_period"></a> [budget\_reset\_period](#input\_budget\_reset\_period) | The reset period for the budget. | `string` | `"MONTHLY"` | no |
| <a name="input_budget_target"></a> [budget\_target](#input\_budget\_target) | The compartment ocid for the budget | `string` | n/a | yes |
| <a name="input_budget_target_type"></a> [budget\_target\_type](#input\_budget\_target\_type) | The target type for the budget | `string` | `"COMPARTMENT"` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The ocid of compartment to provision resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_budget"></a> [budget](#output\_budget) | ----------------------------------------------------------------------------- Budget Output ----------------------------------------------------------------------------- |
| <a name="output_budget_alert_rule"></a> [budget\_alert\_rule](#output\_budget\_alert\_rule) | n/a |
| <a name="output_budget_alert_rule_recipients"></a> [budget\_alert\_rule\_recipients](#output\_budget\_alert\_rule\_recipients) | n/a |
| <a name="output_budget_alert_rule_threshold"></a> [budget\_alert\_rule\_threshold](#output\_budget\_alert\_rule\_threshold) | n/a |
| <a name="output_budget_amount"></a> [budget\_amount](#output\_budget\_amount) | n/a |
| <a name="output_budget_id"></a> [budget\_id](#output\_budget\_id) | n/a |
| <a name="output_budget_target_name"></a> [budget\_target\_name](#output\_budget\_target\_name) | n/a |
<!-- END_TF_DOCS -->    