## Summary
Terraform module for OCI master encryption keys.
The Key could be used for encryption and decryption of data while at rest or in transit.

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
| [oci_kms_key.key](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | The OCID of the compartment where you want to create the master encryption key. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of key | `string` | n/a | yes |
| <a name="input_management_endpoint"></a> [management\_endpoint](#input\_management\_endpoint) | The service endpoint to perform management operations against. | `string` | n/a | yes |
| <a name="input_protection_mode"></a> [protection\_mode](#input\_protection\_mode) | he key's protection mode indicates how the key persists and where cryptographic operations that use the key are performed. | `string` | n/a | yes |
| <a name="input_shape_algorithm"></a> [shape\_algorithm](#input\_shape\_algorithm) | The algorithm used by a key's key versions to encrypt or decrypt. | `string` | n/a | yes |
| <a name="input_shape_length"></a> [shape\_length](#input\_shape\_length) | The length of the key in bytes, expressed as an integer. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_ocid"></a> [key\_ocid](#output\_key\_ocid) | The OCID of the key created |
<!-- END_TF_DOCS -->    