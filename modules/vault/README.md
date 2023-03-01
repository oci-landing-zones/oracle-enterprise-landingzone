## Summary
Terraform module for Vault. It is a key management service that
stores and manages master encryption keys and secrets for secure access to resources.

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
| [oci_kms_vault.vault](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault) | resource |
| [oci_kms_vault_replication.replication](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault_replication) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment where you want to create this vault. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the vault | `string` | n/a | yes |
| <a name="input_enable_replication"></a> [enable\_replication](#input\_enable\_replication) | Option to enable vault replication | `bool` | n/a | yes |
| <a name="input_replica_region"></a> [replica\_region](#input\_replica\_region) | the region to be created replica to. | `string` | n/a | yes |
| <a name="input_vault_type"></a> [vault\_type](#input\_vault\_type) | The type of vault to create. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_endpoint"></a> [management\_endpoint](#output\_management\_endpoint) | The endpoint OCID of the valut |
<!-- END_TF_DOCS -->