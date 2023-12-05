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
| <a name="module_backup_compartment"></a> [backup\_compartment](#module\_backup\_compartment) | ../../modules/compartment | n/a |
| <a name="module_environment_compartment"></a> [environment\_compartment](#module\_environment\_compartment) | ../../modules/compartment | n/a |
| <a name="module_logging_compartment"></a> [logging\_compartment](#module\_logging\_compartment) | ../../modules/compartment | n/a |
| <a name="module_network_compartment"></a> [network\_compartment](#module\_network\_compartment) | ../../modules/compartment | n/a |
| <a name="module_security_compartment"></a> [security\_compartment](#module\_security\_compartment) | ../../modules/compartment | n/a |
| <a name="module_shared_infra_compartment"></a> [shared\_infra\_compartment](#module\_shared\_infra\_compartment) | ../../modules/compartment | n/a |

## Resources

| Name | Type |
|------|------|
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.compartment_replication_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy. | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Set to true to enable logging compartment which stores the configuration information that landing zones is setting up for the customer. | `bool` | `false` | no |
| <a name="input_enable_tf_state_backup"></a> [enable\_tf\_state\_backup](#input\_enable\_tf\_state\_backup) | Set to true to enable logging compartment which contains the bucket for the log files. | `bool` | `false` | no |
| <a name="input_environment_compartment_name"></a> [environment\_compartment\_name](#input\_environment\_compartment\_name) | The name of the compartment that acts as the main compartment for the environment. Resources related to this environment will be created under this compartment. | `string` | `""` | no |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartments"></a> [compartments](#output\_compartments) | n/a |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.