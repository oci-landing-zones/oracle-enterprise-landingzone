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
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_policy"></a> [alarm\_policy](#module\_alarm\_policy) | ../../modules/policies | n/a |
| <a name="module_announcement_subscription"></a> [announcement\_subscription](#module\_announcement\_subscription) | ../../modules/announcement-subscription | n/a |
| <a name="module_architecture_tag"></a> [architecture\_tag](#module\_architecture\_tag) | ../../modules/tag | n/a |
| <a name="module_budget_warning_topic"></a> [budget\_warning\_topic](#module\_budget\_warning\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_iam_warning_topic"></a> [iam\_warning\_topic](#module\_iam\_warning\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_logging_analytics_audit"></a> [logging\_analytics\_audit](#module\_logging\_analytics\_audit) | ../../modules/log-analytics | n/a |
| <a name="module_logging_analytics_default"></a> [logging\_analytics\_default](#module\_logging\_analytics\_default) | ../../modules/log-analytics | n/a |
| <a name="module_network_alarms_critical"></a> [network\_alarms\_critical](#module\_network\_alarms\_critical) | ../../modules/alarms | n/a |
| <a name="module_network_alarms_warning"></a> [network\_alarms\_warning](#module\_network\_alarms\_warning) | ../../modules/alarms | n/a |
| <a name="module_network_critical_topic"></a> [network\_critical\_topic](#module\_network\_critical\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_network_warning_topic"></a> [network\_warning\_topic](#module\_network\_warning\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_security_alarms_critical"></a> [security\_alarms\_critical](#module\_security\_alarms\_critical) | ../../modules/alarms | n/a |
| <a name="module_security_alarms_warning"></a> [security\_alarms\_warning](#module\_security\_alarms\_warning) | ../../modules/alarms | n/a |
| <a name="module_security_critical_topic"></a> [security\_critical\_topic](#module\_security\_critical\_topic) | ../../modules/notification-topic | n/a |
| <a name="module_security_warning_topic"></a> [security\_warning\_topic](#module\_security\_warning\_topic) | ../../modules/notification-topic | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.log_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_log_group_id"></a> [default\_log\_group\_id](#input\_default\_log\_group\_id) | n/a | `string` | n/a | yes |
| <a name="input_enable_network_monitoring_alarms"></a> [enable\_network\_monitoring\_alarms](#input\_enable\_network\_monitoring\_alarms) | Enable Network Monitoring Alarms in Network Compartment | `bool` | n/a | yes |
| <a name="input_enable_security_monitoring_alarms"></a> [enable\_security\_monitoring\_alarms](#input\_enable\_security\_monitoring\_alarms) | Enable Security Monitoring Alarms in Security Compartment | `bool` | n/a | yes |
| <a name="input_enable_workload_monitoring_alarms"></a> [enable\_workload\_monitoring\_alarms](#input\_enable\_workload\_monitoring\_alarms) | Enable Workload Monitoring Alarms in Workload Compartment | `bool` | n/a | yes |
| <a name="input_environment_compartment_id"></a> [environment\_compartment\_id](#input\_environment\_compartment\_id) | ----------------------------------------------------------------------------- Common Variables ----------------------------------------------------------------------------- | `string` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_identity_topic_endpoints"></a> [identity\_topic\_endpoints](#input\_identity\_topic\_endpoints) | List of email addresses for Identity notifications. | `list(string)` | `[]` | no |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_is_create_alarms"></a> [is\_create\_alarms](#input\_is\_create\_alarms) | Enable Alarms Creation in all Compartment | `bool` | n/a | yes |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_network_topic_endpoints"></a> [network\_topic\_endpoints](#input\_network\_topic\_endpoints) | List of email addresses for Network Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_platform_topic_endpoints"></a> [platform\_topic\_endpoints](#input\_platform\_topic\_endpoints) | List of email addresses for Platform notifications. | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label) | Prefix used to avoid naming conflict | `string` | n/a | yes |
| <a name="input_secops_topic_endpoints"></a> [secops\_topic\_endpoints](#input\_secops\_topic\_endpoints) | List of email addresses for Secops Warning and Critical notifications. | `list(string)` | `[]` | no |
| <a name="input_security_compartment_id"></a> [security\_compartment\_id](#input\_security\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |
| <a name="input_workload_compartment_id"></a> [workload\_compartment\_id](#input\_workload\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_workload_topic_endpoints"></a> [workload\_topic\_endpoints](#input\_workload\_topic\_endpoints) | List of email addresses for Workload notifications. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.