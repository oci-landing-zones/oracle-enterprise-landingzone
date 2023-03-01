## Summary
Terraform module for Logging Analytic, a cloud solution in 
Oracle Cloud Infrastructure that lets you index, enrich, 
aggregate, explore, search, analyze, correlate, visualize and monitor 
all log data from your applications and system infrastructure.


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
| [oci_log_analytics_namespace.namespace](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/log_analytics_namespace) | resource |
| [time_sleep.policy_propagation_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_log_analytics_namespaces.logging_analytics_namespaces](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/log_analytics_namespaces) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the root compartment. | `string` | n/a | yes |
| <a name="input_is_onboarded"></a> [is\_onboarded](#input\_is\_onboarded) | Use true if tenancy is to be onboarded to logging analytics and false if tenancy is to be offboarded. | `bool` | n/a | yes |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label) | n/a | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    