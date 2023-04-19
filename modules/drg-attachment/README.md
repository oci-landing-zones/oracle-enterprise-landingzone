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
| [oci_core_drg_attachment.drg_attachment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_drg_attachment_type"></a> [drg\_attachment\_type](#input\_drg\_attachment\_type) | DRG Attacment Network Type | `string` | n/a | yes |
| <a name="input_drg_attachment_vcn_route_type"></a> [drg\_attachment\_vcn\_route\_type](#input\_drg\_attachment\_vcn\_route\_type) | DRG Attacment Network VCN Route Type | `string` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | DRG OCID Value. | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | VCN OCID Value | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->