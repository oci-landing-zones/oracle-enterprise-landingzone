## Summary
Terraform module for OCI Policy creation.

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
| [oci_identity_policy.policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [time_sleep.policy_propagation_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | The OCID of the compartment containing the policy. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of policy | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of policy. | `string` | n/a | yes |
| <a name="input_statements"></a> [statements](#input\_statements) | An array of policy statements written in the policy language. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy"></a> [policy](#output\_policy) | n/a |
<!-- END_TF_DOCS -->    