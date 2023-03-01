<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 4.96.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.96.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_workload_compartment"></a> [workload\_compartment](#module\_workload\_compartment) | ../../modules/compartment | n/a |
| <a name="module_workload_critical_topic"></a> [workload\_critical\_topic](#module\_workload\_critical\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_workload_warning_topic"></a> [workload\_warning\_topic](#module\_workload\_warning\_topic) | ../../modules/notification-topic | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/4.96.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy. | `bool` | `true` | no |
| <a name="input_enable_network_monitoring_alarms"></a> [enable\_network\_monitoring\_alarms](#input\_enable\_network\_monitoring\_alarms) | Enable Network Monitoring Alarms in Network Compartment | `bool` | n/a | yes |
| <a name="input_enable_security_monitoring_alarms"></a> [enable\_security\_monitoring\_alarms](#input\_enable\_security\_monitoring\_alarms) | Enable Security Monitoring Alarms in Security Compartment | `bool` | n/a | yes |
| <a name="input_enable_workload_monitoring_alarms"></a> [enable\_workload\_monitoring\_alarms](#input\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Workload Compartment | `bool` | n/a | yes |
| <a name="input_environment_compartment_id"></a> [environment\_compartment\_id](#input\_environment\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_network_topic_endpoints"></a> [network\_topic\_endpoints](#input\_network\_topic\_endpoints) | List of email addresses for Network Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_secops_topic_endpoints"></a> [secops\_topic\_endpoints](#input\_secops\_topic\_endpoints) | List of email addresses for Secops Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_security_compartment_id"></a> [security\_compartment\_id](#input\_security\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_workload_compartment_id"></a> [workload\_compartment\_id](#input\_workload\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | `""` | no |
| <a name="input_workload_compartment_name"></a> [workload\_compartment\_name](#input\_workload\_compartment\_name) | The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>. | `string` | `""` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | The name of the workload. | `string` | n/a | yes |
| <a name="input_workload_topic_endpoints"></a> [workload\_topic\_endpoints](#input\_workload\_topic\_endpoints) | List of email addresses for Workload notifications. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartment_id"></a> [compartment\_id](#output\_compartment\_id) | The ocid of workload compartment |
| <a name="output_compartment_name"></a> [compartment\_name](#output\_compartment\_name) | The Workload Compartment Name |
<!-- END_TF_DOCS -->