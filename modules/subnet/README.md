## Summary
Terraform module for Virtual Cloud Network, subnets, and default security list.

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
| [oci_core_subnet.subnet](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Option to enable ipv6 | `bool` | `false` | no |
| <a name="input_network_compartment_id"></a> [network\_compartment\_id](#input\_network\_compartment\_id) | the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment. | `string` | n/a | yes |
| <a name="input_security_list_ids"></a> [security\_list\_ids](#input\_security\_list\_ids) | Security List OCID Value. | `string` | n/a | yes |
| <a name="input_subnet_map"></a> [subnet\_map](#input\_subnet\_map) | The map of subnets including subnet name, description, dns label, subnet cidr block. | <pre>map(object({<br>    name                       = string,<br>    description                = string,<br>    dns_label                  = string,<br>    cidr_block                 = string,<br>    prohibit_public_ip_on_vnic = bool<br>  }))</pre> | n/a | yes |
| <a name="input_vcn_cidr_block"></a> [vcn\_cidr\_block](#input\_vcn\_cidr\_block) | The CIDR block of VCN | `string` | n/a | yes |
| <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name) | The display name of VCN | `string` | n/a | yes |
| <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label) | The DNS label of VCN | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | VCN OCID Value | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The subnet OCID |
<!-- END_TF_DOCS -->