<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_user.break_glass_user](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user) | resource |
| [oci_identity_user_group_membership.administrator_group_membership](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user_group_membership) | resource |
| [random_id.user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_identity_groups.administrator_group](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_group_name"></a> [administrator\_group\_name](#input\_administrator\_group\_name) | The name for the administrator group | `string` | `"Administrators"` | no |
| <a name="input_break_glass_user_email"></a> [break\_glass\_user\_email](#input\_break\_glass\_user\_email) | The email address of the break glass user | `string` | n/a | yes |
| <a name="input_break_glass_user_index"></a> [break\_glass\_user\_index](#input\_break\_glass\_user\_index) | the index of the break glass user | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_break_glass_user_list"></a> [break\_glass\_user\_list](#output\_break\_glass\_user\_list) | n/a |
<!-- END_TF_DOCS -->    