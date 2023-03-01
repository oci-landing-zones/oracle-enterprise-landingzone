## Summary
Terraform module for OCI bucket, a container for storing objects in a compartment
within an Object Storage namespace.

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
| [oci_objectstorage_bucket.bucket](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_bucket) | resource |
| [oci_objectstorage_namespace.ns](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/objectstorage_namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment in which to create the bucket. | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The OCID of a master encryption key. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the bucket. Must be unique within an Object Storage namespace. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of object storage bucket | `string` | n/a | yes |
| <a name="input_retention_policy_duration_amount"></a> [retention\_policy\_duration\_amount](#input\_retention\_policy\_duration\_amount) | The timeAmount is interpreted in units defined by the timeUnit parameter. | `string` | n/a | yes |
| <a name="input_retention_policy_duration_time_unit"></a> [retention\_policy\_duration\_time\_unit](#input\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount. | `string` | n/a | yes |
| <a name="input_retention_rule_display_name"></a> [retention\_rule\_display\_name](#input\_retention\_rule\_display\_name) | The display name of retention rule | `string` | n/a | yes |
| <a name="input_storage_tier"></a> [storage\_tier](#input\_storage\_tier) | The type of storage tier of this bucket. | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCID of tenancy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
<!-- END_TF_DOCS -->    