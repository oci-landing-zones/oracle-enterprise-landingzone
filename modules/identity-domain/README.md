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
| [oci_identity_domain.domain](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_domain) | resource |
| [oci_identity_domain_replication_to_region.test_domain_replication_to_region](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_domain_replication_to_region) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the Compartment where domain is created | `string` | n/a | yes |
| <a name="input_domain_admin_email"></a> [domain\_admin\_email](#input\_domain\_admin\_email) | The admin email address. | `string` | `null` | no |
| <a name="input_domain_admin_first_name"></a> [domain\_admin\_first\_name](#input\_domain\_admin\_first\_name) | The admin email address. | `string` | `null` | no |
| <a name="input_domain_admin_last_name"></a> [domain\_admin\_last\_name](#input\_domain\_admin\_last\_name) | The admin email address. | `string` | `null` | no |
| <a name="input_domain_admin_user_name"></a> [domain\_admin\_user\_name](#input\_domain\_admin\_user\_name) | The admin email address. | `string` | `null` | no |
| <a name="input_domain_description"></a> [domain\_description](#input\_domain\_description) | Domain entity description. | `string` | n/a | yes |
| <a name="input_domain_display_name"></a> [domain\_display\_name](#input\_domain\_display\_name) | The mutable display name of the domain. | `string` | n/a | yes |
| <a name="input_domain_home_region"></a> [domain\_home\_region](#input\_domain\_home\_region) | The region's name. | `string` | n/a | yes |
| <a name="input_domain_is_hidden_on_login"></a> [domain\_is\_hidden\_on\_login](#input\_domain\_is\_hidden\_on\_login) | Indicates whether domain is hidden on login screen or not. | `bool` | `false` | no |
| <a name="input_domain_is_notification_bypassed"></a> [domain\_is\_notification\_bypassed](#input\_domain\_is\_notification\_bypassed) | Indicates if admin user created in IDCS stripe would like to receive notification like welcome email or not. | `bool` | `false` | no |
| <a name="input_domain_is_primary_email_required"></a> [domain\_is\_primary\_email\_required](#input\_domain\_is\_primary\_email\_required) | Indicate whether users in the domain are required to have a primary email address or not. | `bool` | `true` | no |
| <a name="input_domain_license_type"></a> [domain\_license\_type](#input\_domain\_license\_type) | The license type of Domain | `string` | n/a | yes |
| <a name="input_domain_replica_region"></a> [domain\_replica\_region](#input\_domain\_replica\_region) | A region for which domain replication is requested for. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | n/a |
| <a name="output_url"></a> [url](#output\_url) | n/a |
<!-- END_TF_DOCS -->    