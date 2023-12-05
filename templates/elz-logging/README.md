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
| <a name="module_architecture_tag"></a> [architecture\_tag](#module\_architecture\_tag) | ../../modules/tag | n/a |
| <a name="module_audit_log_bucket"></a> [audit\_log\_bucket](#module\_audit\_log\_bucket) | ../../modules/bucket | n/a |
| <a name="module_audit_log_service_connector"></a> [audit\_log\_service\_connector](#module\_audit\_log\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_default_log_bucket"></a> [default\_log\_bucket](#module\_default\_log\_bucket) | ../../modules/bucket | n/a |
| <a name="module_default_log_group"></a> [default\_log\_group](#module\_default\_log\_group) | ../../modules/log-group | n/a |
| <a name="module_default_log_service_connector"></a> [default\_log\_service\_connector](#module\_default\_log\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_event_log"></a> [event\_log](#module\_event\_log) | ../../modules/service-log | n/a |
| <a name="module_os_read_log"></a> [os\_read\_log](#module\_os\_read\_log) | ../../modules/service-log | n/a |
| <a name="module_os_write_log"></a> [os\_write\_log](#module\_os\_write\_log) | ../../modules/service-log | n/a |
| <a name="module_service_event_log_bucket"></a> [service\_event\_log\_bucket](#module\_service\_event\_log\_bucket) | ../../modules/bucket | n/a |
| <a name="module_service_event_stream"></a> [service\_event\_stream](#module\_service\_event\_stream) | ../../modules/stream | n/a |
| <a name="module_service_events_service_connector"></a> [service\_events\_service\_connector](#module\_service\_events\_service\_connector) | ../../modules/service-connector | n/a |
| <a name="module_vcn_flow_log"></a> [vcn\_flow\_log](#module\_vcn\_flow\_log) | ../../modules/service-log | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.first_log_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_events_rules.security_event_rules](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/events_rules) | data source |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |
| [oci_objectstorage_namespace.ns](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/objectstorage_namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | The id of the home compartment. | `string` | n/a | yes |
| <a name="input_home_compartment_name"></a> [home\_compartment\_name](#input\_home\_compartment\_name) | The name of the home compartment. | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_is_service_connector_limit"></a> [is\_service\_connector\_limit](#input\_is\_service\_connector\_limit) | Restrict Number of Service Connector Deployment | `bool` | n/a | yes |
| <a name="input_logging_compartment_id"></a> [logging\_compartment\_id](#input\_logging\_compartment\_id) | The ocid of the logging compartment. | `string` | n/a | yes |
| <a name="input_master_encryption_key"></a> [master\_encryption\_key](#input\_master\_encryption\_key) | The ocid of master encryption key | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label) | Prefix used to avoid naming conflict | `string` | n/a | yes |
| <a name="input_retention_policy_duration_amount"></a> [retention\_policy\_duration\_amount](#input\_retention\_policy\_duration\_amount) | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | n/a | yes |
| <a name="input_retention_policy_duration_time_unit"></a> [retention\_policy\_duration\_time\_unit](#input\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount. | `string` | n/a | yes |
| <a name="input_security_compartment_id"></a> [security\_compartment\_id](#input\_security\_compartment\_id) | The ocid of the security compartment. | `string` | n/a | yes |
| <a name="input_subnets_map"></a> [subnets\_map](#input\_subnets\_map) | n/a | `map(string)` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_log_group_id"></a> [log\_group\_id](#output\_log\_group\_id) | n/a |
| <a name="output_stream_id"></a> [stream\_id](#output\_stream\_id) | n/a |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.