## Summary
Terraform module for Stream service and event rule.
It provides a fully managed, scalable, and durable solution for ingesting
and consuming high-volume data streams in real-time. Use Streaming for any
use case in which data is produced and processed continually and sequentially
in a publish-subscribe messaging model.

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
| [oci_events_rule.rule](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/events_rule) | resource |
| [oci_streaming_stream.stream](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/streaming_stream) | resource |
| [oci_streaming_stream_pool.stream_pool](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/streaming_stream_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment that contains the stream. | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Custom Encryption Key (Master Key) ocid. | `string` | n/a | yes |
| <a name="input_rule_action_is_enabled"></a> [rule\_action\_is\_enabled](#input\_rule\_action\_is\_enabled) | Option to enable rule action | `bool` | n/a | yes |
| <a name="input_rule_action_type"></a> [rule\_action\_type](#input\_rule\_action\_type) | The action to perform if the condition in the rule matches an event.(ONS, OSS, FAAS) | `string` | n/a | yes |
| <a name="input_rule_condition"></a> [rule\_condition](#input\_rule\_condition) | A filter that specifies the event that will trigger actions associated with this rule. | `string` | n/a | yes |
| <a name="input_rule_display_name"></a> [rule\_display\_name](#input\_rule\_display\_name) | The display name of the rule | `string` | n/a | yes |
| <a name="input_rule_is_enabled"></a> [rule\_is\_enabled](#input\_rule\_is\_enabled) | Option to enable rule | `bool` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | The name of the stream. | `string` | n/a | yes |
| <a name="input_stream_partitions"></a> [stream\_partitions](#input\_stream\_partitions) | The number of partitions in the stream. | `number` | n/a | yes |
| <a name="input_stream_pool_name"></a> [stream\_pool\_name](#input\_stream\_pool\_name) | The name of stream pool | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stream_id"></a> [stream\_id](#output\_stream\_id) | The OCID of the stream created |
<!-- END_TF_DOCS -->    