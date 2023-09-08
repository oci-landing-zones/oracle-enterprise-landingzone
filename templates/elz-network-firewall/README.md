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
| <a name="module_firewall_threat_log"></a> [firewall\_threat\_log](#module\_firewall\_threat\_log) | ../../modules/service-log | n/a |
| <a name="module_firewall_traffic_log"></a> [firewall\_traffic\_log](#module\_firewall\_traffic\_log) | ../../modules/service-log | n/a |
| <a name="module_network_firewall"></a> [network\_firewall](#module\_network\_firewall) | ../../modules/network-firewall | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_core_subnet.oci_network_firewall_subnet](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/resources/core_subnet) | resource |
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_region_subscriptions.regions](https://registry.terraform.io/providers/oracle/oci/5.1.0/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_network_firewall"></a> [enable\_network\_firewall](#input\_enable\_network\_firewall) | Enable Network Firewall in Enviornment. | `bool` | n/a | yes |
| <a name="input_enable_traffic_threat_log"></a> [enable\_traffic\_threat\_log](#input\_enable\_traffic\_threat\_log) | Enable Network Firewall Threat and Traffic Logs in Enviornment. | `bool` | n/a | yes |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U | `string` | n/a | yes |
| <a name="input_home_compartment_id"></a> [home\_compartment\_id](#input\_home\_compartment\_id) | Home Compartment ID | `string` | n/a | yes |
| <a name="input_is_baseline_deploy"></a> [is\_baseline\_deploy](#input\_is\_baseline\_deploy) | TagNameSpace Optimization: Enable this flag to disable dependent module TagNameSpace Tag Creation. | `bool` | n/a | yes |
| <a name="input_nfw_instance_name"></a> [nfw\_instance\_name](#input\_nfw\_instance\_name) | Network Firewall Instance Name. | `string` | n/a | yes |
| <a name="input_nfw_instance_policy"></a> [nfw\_instance\_policy](#input\_nfw\_instance\_policy) | Network Firewall Instance Policy Name. | `string` | n/a | yes |
| <a name="input_nfw_subnet_cidr_block"></a> [nfw\_subnet\_cidr\_block](#input\_nfw\_subnet\_cidr\_block) | Network Firewall Subnet CIDR IP Block. | `string` | n/a | yes |
| <a name="input_nfw_subnet_type"></a> [nfw\_subnet\_type](#input\_nfw\_subnet\_type) | Network Firewall Subnet Type. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI region | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->