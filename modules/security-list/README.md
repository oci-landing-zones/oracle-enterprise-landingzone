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
| [oci_core_security_list.security_list_spoke](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | Compartment OCID ID | `string` | n/a | yes |
| <a name="input_security_list_egress_description"></a> [security\_list\_egress\_description](#input\_security\_list\_egress\_description) | Ingress: Security List Rule Description | `string` | n/a | yes |
| <a name="input_security_list_egress_destination"></a> [security\_list\_egress\_destination](#input\_security\_list\_egress\_destination) | Egress: Security List Protocol | `string` | n/a | yes |
| <a name="input_security_list_egress_destination_type"></a> [security\_list\_egress\_destination\_type](#input\_security\_list\_egress\_destination\_type) | Ingress: Security List Rule Source Type | `string` | n/a | yes |
| <a name="input_security_list_egress_protocol"></a> [security\_list\_egress\_protocol](#input\_security\_list\_egress\_protocol) | Ingress: Security List Protocol | `string` | n/a | yes |
| <a name="input_security_list_ingress_description"></a> [security\_list\_ingress\_description](#input\_security\_list\_ingress\_description) | Egress: Security List Rule Description | `string` | n/a | yes |
| <a name="input_security_list_ingress_protocol"></a> [security\_list\_ingress\_protocol](#input\_security\_list\_ingress\_protocol) | Egress: Security List Rule Description | `string` | n/a | yes |
| <a name="input_security_list_ingress_source"></a> [security\_list\_ingress\_source](#input\_security\_list\_ingress\_source) | Egress: Security List Rule Protocol | `string` | n/a | yes |
| <a name="input_security_list_ingress_source_type"></a> [security\_list\_ingress\_source\_type](#input\_security\_list\_ingress\_source\_type) | Egress: Security List Rule Destination Type | `string` | n/a | yes |
| <a name="input_spoke_security_list_display_name"></a> [spoke\_security\_list\_display\_name](#input\_spoke\_security\_list\_display\_name) | VCN OCID ID | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | VCN OCID ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_list_id"></a> [security\_list\_id](#output\_security\_list\_id) | The OCID of the Security List |
<!-- END_TF_DOCS -->  

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.