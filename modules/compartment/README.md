## Summary
Terraform module for OCI Compartment creation.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_compartment.compartment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [time_sleep.compartment_replication_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_description"></a> [compartment\_description](#input\_compartment\_description) | Description of the compartment to create. | `string` | n/a | yes |
| <a name="input_compartment_name"></a> [compartment\_name](#input\_compartment\_name) | Name of the compartment to create. | `string` | n/a | yes |
| <a name="input_compartment_parent_id"></a> [compartment\_parent\_id](#input\_compartment\_parent\_id) | OCID of the parent compartment. | `string` | n/a | yes |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Allows the compartment to delete on terraform destroy. | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartment"></a> [compartment](#output\_compartment) | The full compartment resource including all attributes |
| <a name="output_compartment_id"></a> [compartment\_id](#output\_compartment\_id) | The OCID of the compartment created |
| <a name="output_compartment_name"></a> [compartment\_name](#output\_compartment\_name) | The name of the compartment created |
<!-- END_TF_DOCS -->    
