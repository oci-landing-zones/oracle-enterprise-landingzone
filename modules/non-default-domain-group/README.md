## Summary
Terraform module for OCI Identity Domain.
A container for managing users and roles, federating and provisioning
of users, secure application integration through Oracle Single Sign-On (SSO)
configuration, and SAML/OAuth based Identity Provider administration.

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
| [oci_identity_domains_group.test_group](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_domains_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_display_name"></a> [group\_display\_name](#input\_group\_display\_name) | Identity Group Display Name. | `string` | n/a | yes |
| <a name="input_idcs_endpoint"></a> [idcs\_endpoint](#input\_idcs\_endpoint) | The basic endpoint for the identity domain. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    