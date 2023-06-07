## Summary
Terraform module for Network Firewall, includes firewall creation and firewall rules/policies.

## Requirements

* VCN

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
| [oci_network_firewall_network_firewall.network_firewall](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/network_firewall_network_firewall) | resource |
| [oci_network_firewall_network_firewall_policy.network_firewall_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/network_firewall_network_firewall_policy) | resource |
| [time_sleep.network_firewall_ip_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_core_private_ips.firewall_subnet_private_ip](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_private_ips) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment containing the Network Firewall. | `string` | n/a | yes |
| <a name="input_ip_address_lists"></a> [ip\_address\_lists](#input\_ip\_address\_lists) | The list of ip address | `map(any)` | n/a | yes |
| <a name="input_network_firewall_name"></a> [network\_firewall\_name](#input\_network\_firewall\_name) | The OCI Network Firewall Name | `string` | n/a | yes |
| <a name="input_network_firewall_policy_name"></a> [network\_firewall\_policy\_name](#input\_network\_firewall\_policy\_name) | The name of network firewall policy | `string` | n/a | yes |
| <a name="input_network_firewall_subnet_id"></a> [network\_firewall\_subnet\_id](#input\_network\_firewall\_subnet\_id) | The OCID of the subnet associated with the Network Firewall. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | The list of security rules | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | The OCID of network firewall |
| <a name="output_firewall_ip_id"></a> [firewall\_ip\_id](#output\_firewall\_ip\_id) | The OCID of network firewall ip |

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
| [oci_network_firewall_network_firewall.network_firewall](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/network_firewall_network_firewall) | resource |
| [oci_network_firewall_network_firewall_policy.network_firewall_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/network_firewall_network_firewall_policy) | resource |
| [time_sleep.network_firewall_ip_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment containing the Network Firewall. | `string` | n/a | yes |
| <a name="input_ip_address_lists"></a> [ip\_address\_lists](#input\_ip\_address\_lists) | The list of ip address | `map(any)` | n/a | yes |
| <a name="input_network_firewall_name"></a> [network\_firewall\_name](#input\_network\_firewall\_name) | The OCI Network Firewall Name | `string` | n/a | yes |
| <a name="input_network_firewall_policy_name"></a> [network\_firewall\_policy\_name](#input\_network\_firewall\_policy\_name) | The name of network firewall policy | `string` | n/a | yes |
| <a name="input_network_firewall_subnet_id"></a> [network\_firewall\_subnet\_id](#input\_network\_firewall\_subnet\_id) | The OCID of the subnet associated with the Network Firewall. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | The list of security rules | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | The OCID of network firewall |
| <a name="output_firewall_ip"></a> [firewall\_ip](#output\_firewall\_ip) | The IP address network firewall |
<!-- END_TF_DOCS -->