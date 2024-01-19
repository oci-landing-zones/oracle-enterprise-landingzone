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
| [oci_network_firewall_network_firewall.network_firewall](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/network_firewall_network_firewall) | resource |
| [oci_network_firewall_network_firewall_policy.network_firewall_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/network_firewall_network_firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_address_lists"></a> [ip\_address\_lists](#input\_ip\_address\_lists) | The list of ip address. | `map(any)` | n/a | yes |
| <a name="input_network_compartment_ocid"></a> [network\_compartment\_ocid](#input\_network\_compartment\_ocid) | The OCID of the compartment containing the Network Firewall. | `string` | n/a | yes |
| <a name="input_network_firewall_name"></a> [network\_firewall\_name](#input\_network\_firewall\_name) | OCI Network Firewall Name. | `string` | n/a | yes |
| <a name="input_network_firewall_policy_action"></a> [network\_firewall\_policy\_action](#input\_network\_firewall\_policy\_action) | Network Firewall Policy Action. | `string` | n/a | yes |
| <a name="input_network_firewall_policy_name"></a> [network\_firewall\_policy\_name](#input\_network\_firewall\_policy\_name) | The name of network firewall policy. | `string` | n/a | yes |
| <a name="input_network_firewall_subnet_id"></a> [network\_firewall\_subnet\_id](#input\_network\_firewall\_subnet\_id) | The OCID of the subnet associated with the Network Firewall. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | The list of security rules. | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | The OCID of network firewall |
| <a name="output_firewall_ip"></a> [firewall\_ip](#output\_firewall\_ip) | The IP address network firewall |
| <a name="output_firewall_ip_id"></a> [firewall\_ip\_id](#output\_firewall\_ip\_id) | The OCID of network firewall ip |
<!-- END_TF_DOCS -->

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.